using StatisticalRethinking
using CmdStan, StanMCMCChain

ProjDir = rel_path("..", "scripts", "12")
cd(ProjDir)

d = CSV.read(rel_path( "..", "data",  "Kline.csv"), delim=';');
size(d) # Should be 10x5

# New col log_pop, set log() for population data
d[:log_pop] = map((x) -> log(x), d[:population]);
d[:society] = 1:10;
first(d[[:culture, :population, :log_pop, :society]], 5)

m12_6 = "
data {
    int N;
    int N_societies;
    int total_tools[N];
    real logpop[N];
    int society[N];
}
parameters{
    real a;
    real bp;
    vector[N_societies] a_society;
    real<lower=0> sigma_society;
}
model{
    vector[N_societies] mu;
    sigma_society ~ cauchy( 0 , 1 );
    a_society ~ normal( 0 , sigma_society );
    bp ~ normal( 0 , 1 );
    a ~ normal( 0 , 10 );
    for ( i in 1:N ) {
        mu[i] = a + a_society[society[i]] + bp * logpop[i];
        mu[i] = exp(mu[i]);
    }
    total_tools ~ poisson( mu );
}
";

# Define the Stanmodel and set the output format to :mcmcchain.

stanmodel = Stanmodel(name="m12.6",  model=m12_6, output_format=:mcmcchain);

# Input data for cmdstan

m12_6_data = Dict("N" => size(d, 1),"N_societies" => 10,  
"total_tools" => d[:total_tools], "logpop" => d[:log_pop],
"society" => d[:society]);
        
# Sample using cmdstan

rc, chn, cnames = stan(stanmodel, m12_6_data, ProjDir, diagnostics=false, summary=false, CmdStanDir=CMDSTAN_HOME);

# Describe the draws

describe(chn)

