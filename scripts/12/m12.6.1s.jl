using StatisticalRethinking
using CmdStan, StanMCMCChain

ProjDir = rel_path("..", "scripts", "12")

d = CSV.read(rel_path( "..", "data",  "Kline.csv"), delim=';');
size(d) # Should be 10x5

# New col logpop, set log() for population data
d[:logpop] = map((x) -> log(x), d[:population]);
d[:society] = 1:10;

first(d, 5)

m12_6_1 = "
data{
    int total_tools[10];
    real logpop[10];
    int society[10];
}
parameters{
    real a;
    real bp;
    vector[10] a_society;
    real<lower=0> sigma_society;
}
model{
    vector[10] mu;
    sigma_society ~ cauchy( 0 , 1 );
    a_society ~ normal( 0 , sigma_society );
    bp ~ normal( 0 , 1 );
    a ~ normal( 0 , 10 );
    for ( i in 1:10 ) {
        mu[i] = a + a_society[society[i]] + bp * logpop[i];
        mu[i] = exp(mu[i]);
    }
    total_tools ~ poisson( mu );
}
";

# Define the Stanmodel and set the output format to :mcmcchain.

stanmodel = Stanmodel(name="m12.6.1",  model=m12_6_1, output_format=:mcmcchain);

# Input data for cmdstan

m12_6_1_data = Dict("total_tools" => d[:total_tools], "logpop" => d[:logpop], "society" => d[:society]);
        
# Sample using cmdstan

rc, chn, cnames = stan(stanmodel, m12_6_1_data, ProjDir, diagnostics=false, summary=false, CmdStanDir=CMDSTAN_HOME);

# Describe the draws

describe(chn)

