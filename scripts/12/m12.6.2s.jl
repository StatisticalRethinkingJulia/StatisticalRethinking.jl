
using StatisticalRethinking
using CmdStan, StanMCMCChain

ProjDir = rel_path("..", "scripts", "12")

d = CSV.read(rel_path( "..", "data",  "Kline.csv"), delim=';');
size(d) # Should be 10x5

# New col log_pop, set log() for population data
d[:log_pop] = map((x) -> log(x), d[:population]);
d[:society] = 1:10;

first(d, 5)

m12_6 = "
  data {
    int N;
    int T[N];
    int N_societies;
    int society[N];
    int P[N];
  }
  parameters {
    real alpha;
    vector[N_societies] a_society;
    real bp;
    real<lower=0> sigma_society;
  }
  model {
    vector[N] mu;
    target += normal_lpdf(alpha | 0, 10);
    target += normal_lpdf(bp | 0, 1);
    target += cauchy_lpdf(sigma_society | 0, 1);
    target += normal_lpdf(a_society | 0, sigma_society);
    for(i in 1:N) mu[i] = alpha + a_society[society[i]] + bp * log(P[i]);
    target += poisson_log_lpmf(T | mu);
  }
  generated quantities {
    vector[N] log_lik;
    {
    vector[N] mu;
    for(i in 1:N) {
      mu[i] = alpha + a_society[society[i]] + bp * log(P[i]);
      log_lik[i] = poisson_log_lpmf(T[i] | mu[i]);
    }
    }
  }
";

# Define the Stanmodel and set the output format to :mcmcchain.

stanmodel = Stanmodel(name="m12.6",  model=m12_6, output_format=:mcmcchain);

# Input data for cmdstan

m12_6_data = Dict("N" => size(d, 1), "T" => d[:total_tools], "N_societies" => 10, "society" => d[:society], "P" => d[:population]);
        
# Sample using cmdstan

rc, chn, cnames = stan(stanmodel, m12_6_data, ProjDir, diagnostics=false, summary=false, CmdStanDir=CMDSTAN_HOME);

# Describe the draws

describe(chn)

