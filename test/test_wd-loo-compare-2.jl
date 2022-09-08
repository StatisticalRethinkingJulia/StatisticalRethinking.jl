using ParetoSmooth, AxisKeys
import ParetoSmooth: psis_loo, loo_compare
using NamedTupleTools, Distributions
using StanSample
using StatisticalRethinking
using Test

df = CSV.read(sr_datadir("WaffleDivorce.csv"), DataFrame);
df[!, :M] = zscore(df.Marriage)
df[!, :A] = zscore(df.MedianAgeMarriage)
df[!, :D] = zscore(df.Divorce)
data = (N=size(df, 1), D=df.D, A=df.A, M=df.M)

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
    vector[N] loglik;
    for (i in 1:N)
        loglik[i] = normal_lpdf(D[i] | mu[i], sigma);
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
    vector[N] loglik;
    for (i in 1:N)
        loglik[i] = normal_lpdf(D[i] | mu[i], sigma);
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
    vector[N] loglik;
    for (i in 1:N)
        loglik[i] = normal_lpdf(D[i] | mu[i], sigma);
}
";

m5_1s = SampleModel("m5.1s", stan5_1)
rc5_1s = stan_sample(m5_1s; data)

m5_2s = SampleModel("m5.2s", stan5_2)
rc5_2s = stan_sample(m5_2s; data)

m5_3s = SampleModel("m5.3s", stan5_3)
rc5_3s = stan_sample(m5_3s; data)

function loo_compare2(models::Vector{SampleModel}; 
    loglikelihood_name="loglik",
    model_names=nothing,
    sort_models=true, 
    show_psis=true)

    nmodels = length(models)
    model_names = [models[i].name for i in 1:nmodels]

    chains_vec = read_samples.(models, :dataframe) # Obtain KeyedArray chains
    chains_vec = DataFrame.(chains_vec, :loglik)
    chains_vec = Array.(chains_vec)
    println(length(chains_vec))
    println(typeof(chains_vec[1]))
    new_vec = Array{Float64, 3}[]
    for i in 1:3
        chains_vec[i] = permutedims(chains_vec[i], (2, 1))
        num_params = size(chains_vec[i], 1)
        num_samples = models[i].num_samples
        num_chains = models[i].num_chains
        println([i, size(chains_vec[i]), num_params, num_samples, num_chains])
        println()
        chn = reshape(chains_vec[i], (num_params, num_samples, num_chains))
        append!(new_vec, [chn])
        println([i, length(new_vec), size(new_vec[i])])
    end
    loo_compare2(chains_vec; loglikelihood_name, model_names, sort_models, show_psis)
end

function loo_compare2(ll_vec::Vector{<: Array}; 
    loglikelihood_name="loglik",
    model_names=nothing,
    sort_models=true, 
    show_psis=true)

    nmodels = length(ll_vec)

    #ll_vec = Array.(matrix.(chains_vec, loglikelihood_name)) # Extract loglik matrix
    #ll_vecp = map(to_paretosmooth, ll_vec) # Permute dims for ParetoSmooth
    psis_vec = psis_loo.(ll_vec) # Compute PsisLoo for all models

    if show_psis # If a printout is needed
        for i in 1:nmodels
            psis_vec[i] |> display
        end
    end

    loo_compare(psis_vec...; model_names, sort_models)
end

if success(rc5_1s) && success(rc5_2s) && success(rc5_3s)

    println()
    nt5_1s = read_samples(m5_1s, :particles)
    NamedTupleTools.select(nt5_1s, (:a, :bA, :sigma)) |> display
    println()
    nt5_2s = read_samples(m5_2s, :particles)
    NamedTupleTools.select(nt5_2s, (:a, :bM, :sigma)) |> display
    println()
    nt5_3s = read_samples(m5_3s, :particles)
    NamedTupleTools.select(nt5_3s, (:a, :bA, :bM, :sigma)) |> display
    println("\n")

    models = [m5_1s, m5_2s, m5_3s]
    loo_comparison = loo_compare2(models)
    println()
    loo_comparison |> display
    println()
end

@testset "loo_compare" begin
    @test loo_comparison.estimates(Symbol("m5.1s"), :cv_elpd) ≈ 0 atol=0.01
    @test loo_comparison.estimates(Symbol("m5.1s"), :cv_avg) ≈ 0 atol=0.01
    @test loo_comparison.estimates(Symbol("m5.1s"), :weight) ≈ 0.7 atol=0.1

    @test loo_comparison.estimates(Symbol("m5.2s"), :cv_elpd) ≈ -6.9 atol=0.6
    @test loo_comparison.estimates(Symbol("m5.2s"), :cv_avg) ≈ -0.13 atol=0.02
    @test loo_comparison.estimates(Symbol("m5.2s"), :weight) ≈ 0.0 atol=0.1

    @test loo_comparison.estimates(Symbol("m5.3s"), :cv_elpd) ≈ -0.65 atol=0.6
    @test loo_comparison.estimates(Symbol("m5.3s"), :cv_avg) ≈ -0.01 atol=0.02
    @test loo_comparison.estimates(Symbol("m5.3s"), :weight) ≈ 0.34 atol=0.1
end
