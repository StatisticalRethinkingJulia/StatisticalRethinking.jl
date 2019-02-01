# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
using CmdStan, StanMCMCChain
gr(size=(500,500));

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "10")
cd(ProjDir)

# ### snippet 10.4

d = CSV.read(rel_path("..", "data", "chimpanzees.csv"), delim=';');
df = convert(DataFrame, d);

first(df, 5)

# Define the Stan language model

m_10_04_model = "
data{
    int N;
    int N_actors;
    int pulled_left[N];
    int prosoc_left[N];
    int condition[N];
    int actor[N];
}
parameters{
    vector[N_actors] a;
    real bp;
    real bpC;
}
model{
    vector[N] p;
    bpC ~ normal( 0 , 10 );
    bp ~ normal( 0 , 10 );
    a ~ normal( 0 , 10 );
    for ( i in 1:504 ) {
        p[i] = a[actor[i]] + (bp + bpC * condition[i]) * prosoc_left[i];
        p[i] = inv_logit(p[i]);
    }
    pulled_left ~ binomial( 1 , p );
}
";

# Define the Stanmodel and set the output format to :mcmcchain.

stanmodel = Stanmodel(name="m_10_04_model", 
monitors = ["a.1", "a.2", "a.3", "a.4", "a.5", "a.6", "a.7", "bp", "bpC"],
model=m_10_04_model, output_format=:mcmcchain);

# Input data for cmdstan

m_10_04_data = Dict("N" => size(df, 1), "N_actors" => length(unique(df[:actor])), 
"actor" => df[:actor], "pulled_left" => df[:pulled_left],
"prosoc_left" => df[:prosoc_left], "condition" => df[:condition]);

# Sample using cmdstan

rc, chn, cnames = stan(stanmodel, m_10_04_data, ProjDir, diagnostics=false,
  summary=false, CmdStanDir=CMDSTAN_HOME);

# Result rethinking

# Result rethinking

rethinking = "
   mean   sd  5.5% 94.5% n_eff Rhat
      mean   sd  5.5% 94.5% n_eff Rhat
a[1] -0.74 0.27 -1.17 -0.31  3838    1
a[2] 11.02 5.53  4.46 21.27  1759    1
a[3] -1.05 0.28 -1.50 -0.61  3784    1
a[4] -1.05 0.27 -1.48 -0.62  3761    1
a[5] -0.74 0.27 -1.18 -0.32  4347    1
a[6]  0.21 0.27 -0.23  0.66  3932    1
a[7]  1.81 0.39  1.19  2.46  4791    1
bp    0.84 0.26  0.42  1.26  2586    1
";

# Describe the draws

describe(chn)

# End of `10/m10.02s.jl`
