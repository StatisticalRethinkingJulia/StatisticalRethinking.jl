#
# Unfortunately the current loo_compare in ParetoSmooth does not
# work well in Pluto and is nit convenient for SR. Here I'm experimenten
# with a more elaborate version.
#
# This script needs the SR2StanPluto project environment.
#

using StanSample, ParetoSmooth
using AxisKeys, NamedTupleTools
using PrettyTables, StatsPlots
using StatisticalRethinking
using StatisticalRethinkingPlots, Test

df = CSV.read(sr_datadir("WaffleDivorce.csv"), DataFrame);
scale!(df, [:Marriage, :MedianAgeMarriage, :Divorce])
data = (N=size(df, 1), D=df.Divorce_s, A=df.MedianAgeMarriage_s,
    M=df.Marriage_s)

stan5_1 = "
data {
    int < lower = 1 > N; // Sample size
    vector[N] D; // Outcome
    vector[N] A; // Predictor
}
parameters {
    real a; // Intercept
    real bA; // Slope (regression coefficients)
    real < lower = 0 > sigma;    // Error SD
}
transformed parameters {
    vector[N] mu;               // mu is a vector
    for (i in 1:N)
        mu[i] = a + bA * A[i];
}
model {
    a ~ normal(0, 0.2);         //Priors
    bA ~ normal(0, 0.5);
    sigma ~ exponential(1);
    D ~ normal(mu , sigma);     // Likelihood
}
generated quantities {
    vector[N] log_lik;
    for (i in 1:N)
        log_lik[i] = normal_lpdf(D[i] | mu[i], sigma);
}
";

stan5_2 = "
data {
    int N;
    vector[N] D;
    vector[N] M;
}
parameters {
    real a;
    real bM;
    real<lower=0> sigma;
}
transformed parameters {
    vector[N] mu;
    for (i in 1:N)
        mu[i]= a + bM * M[i];

}
model {
    a ~ normal( 0 , 0.2 );
    bM ~ normal( 0 , 0.5 );
    sigma ~ exponential( 1 );
    D ~ normal( mu , sigma );
}
generated quantities {
    vector[N] log_lik;
    for (i in 1:N)
        log_lik[i] = normal_lpdf(D[i] | mu[i], sigma);
}
";

stan5_3 = "
data {
  int N;
  vector[N] D;
  vector[N] M;
  vector[N] A;
}
parameters {
  real a;
  real bA;
  real bM;
  real<lower=0> sigma;
}
transformed parameters {
    vector[N] mu;
    for (i in 1:N)
        mu[i] = a + bA * A[i] + bM * M[i];
}
model {
  a ~ normal( 0 , 0.2 );
  bA ~ normal( 0 , 0.5 );
  bM ~ normal( 0 , 0.5 );
  sigma ~ exponential( 1 );
  D ~ normal( mu , sigma );
}
generated quantities{
    vector[N] log_lik;
    for (i in 1:N)
        log_lik[i] = normal_lpdf(D[i] | mu[i], sigma);
}
";

m5_1s = SampleModel("m5.1s", stan5_1)
rc5_1s = stan_sample(m5_1s; data)

m5_2s = SampleModel("m5.2s", stan5_2)
rc5_2s = stan_sample(m5_2s; data)

m5_3s = SampleModel("m5.3s", stan5_3)
rc5_3s = stan_sample(m5_3s; data)

struct LooCompare1
    psis::Vector{PsisLoo}
    table::KeyedArray
end

function to_paretosmooth(ll, pd = [3,1, 2])
    permutedims(ll, [3, 1, 2])
end

function loo_compare1(models::Vector{SampleModel}; 
    loglikelihood_name="log_lik",
    model_names=nothing,
    sort_models=true, 
    show_psis=true)

    nmodels = length(models)
    mnames = [models[i].name for i in 1:nmodels]

    chains_vec = read_samples.(models)
    ll_vec = Array.(matrix.(chains_vec, loglikelihood_name))
    ll_vecp = map(to_paretosmooth, ll_vec)
    psis_vec = psis_loo.(ll_vecp)

    if show_psis
        for i in 1:nmodels
            psis_vec[i] |> display
        end
    end

    psis_values = Vector{Float64}(undef, nmodels)
    se_values = Vector{Float64}(undef, nmodels)
    loos = Vector{Vector{Float64}}(undef, nmodels)

    for i in 1:nmodels
        psis_values[i] = psis_vec[i].estimates(:cv_elpd, :total)
        se_values[i] = psis_vec[i].estimates(:cv_elpd, :se_total)
        loos[i] = psis_vec[i].pointwise(:cv_elpd)
    end

    if sort_models
        ind = sortperm([psis_values[i][1] for i in 1:nmodels]; rev=true)
        psis_vec = psis_vec[ind]
        psis_values = psis_values[ind]
        se_values = se_values[ind]
        loos = loos[ind]
        mnames = mnames[ind]
    end

    # Setup comparison vectors

    elpd_diff = zeros(nmodels)
    se_diff = zeros(nmodels)
    weight = ones(nmodels)

    # Compute comparison values

    for i in 2:nmodels
        elpd_diff[i] = psis_values[i] - psis_values[1]
        diff = loos[1] - loos[i]
        se_diff[i] = √(length(loos[i]) * var(diff; corrected=false))
    end
    data = elpd_diff
    data = hcat(data, se_diff)

    sumval = sum([exp(psis_values[i]) for i in 1:nmodels])
    @. weight = exp(psis_values) / sumval
    data = hcat(data, weight)
    
    # Create KeyedArray object

    table = KeyedArray(
        data,
        model = mnames,
        statistic = [:cv_elpd, :se_diff, :weight],
    )

    # Return LooCompare object
    
    LooCompare1(psis_vec, table)

end


function Base.show(io::IO, ::MIME"text/plain", loo_compare::LooCompare1)
    table = loo_compare.table
    return pretty_table(
        table;
        compact_printing=false,
        header=table.statistic,
        row_names=table.model,
        formatters=ft_printf("%5.2f"),
        alignment=:r,
    )
end


if success(rc5_1s) && success(rc5_2s) && success(rc5_3s)

    nt5_1s = read_samples(m5_1s, :particles)
    NamedTupleTools.select(nt5_1s, (:a, :bA, :sigma)) |> display
    nt5_2s = read_samples(m5_2s, :particles)
    NamedTupleTools.select(nt5_2s, (:a, :bM, :sigma)) |> display
    nt5_3s = read_samples(m5_3s, :particles)
    NamedTupleTools.select(nt5_3s, (:a, :bA, :bM, :sigma)) |> display
    println()

    models = [m5_1s, m5_2s, m5_3s]
    loo_comparison = loo_compare1(models)
    println()
    
    for i in 1:length(models)
        pw = loo_comparison.psis[i].pointwise
        pk_plot(pw(:pareto_k))
        savefig(joinpath(@__DIR__, "m5.$(i)s.png"))
    end
    
    loo_comparison |> display
end
#=
With SR/ulam():
```
       PSIS    SE dPSIS  dSE pPSIS weight
m5.1u 126.0 12.83   0.0   NA   3.7   0.67
m5.3u 127.4 12.75   1.4 0.75   4.7   0.33
m5.2u 139.5  9.95  13.6 9.33   3.0   0.00
```
=#
