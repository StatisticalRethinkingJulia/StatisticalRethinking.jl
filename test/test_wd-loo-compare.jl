using StanSample, ParetoSmooth, StatsBase
using NamedTupleTools, Test
using StatisticalRethinking

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

if success(rc5_1s) && success(rc5_2s) && success(rc5_3s)

    nt5_1s = read_samples(m5_1s, :particles)
    NamedTupleTools.select(nt5_1s, (:a, :bA, :sigma)) |> display
    println()
    nt5_2s = read_samples(m5_2s, :particles)
    NamedTupleTools.select(nt5_2s, (:a, :bM, :sigma)) |> display
    println()
    nt5_3s = read_samples(m5_3s, :particles)
    NamedTupleTools.select(nt5_3s, (:a, :bA, :bM, :sigma)) |> display
    println()

    models = [m5_1s, m5_2s, m5_3s]
    loo_comparison = loo_compare(models)
    println()
    loo_comparison |> display
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
