# Load Julia packages (libraries) needed  for the snippets in chapter 0

using StatisticalRethinking
using CmdStan, StanMCMCChain
gr(size=(500,500));

# CmdStan uses a tmp directory to store the output of cmdstan

ProjDir = rel_path("..", "scripts", "08")
cd(ProjDir)

# ### snippet 10.1

d = CSV.read(rel_path("..", "data", "chimpanzees.csv"), delim=';');
df = convert(DataFrame, d);

first(df, 5)

# Define the Stan language model

m_10_01_model = "
data{
    int N;
    int pulled_left[N];
}
parameters{
    real a;
}
model{
    real p;
    a ~ normal( 0 , 10 );
    pulled_left ~ binomial( 1 , inv_logit(a) );
}
";

# Define the Stanmodel and set the output format to :mcmcchain.

stanmodel = Stanmodel(name="m_10_01_model", 
monitors = ["a"],
model=m_10_01_model, output_format=:mcmcchain);

# Input data for cmdstan

m_10_01_data = Dict("N" => size(df, 1), 
"pulled_left" => df[:pulled_left]);

# Sample using cmdstan

rc, chn, cnames = stan(stanmodel, m_10_01_data, ProjDir, diagnostics=false,
  summary=false, CmdStanDir=CMDSTAN_HOME);

# Result rethinking

rethinking = "
  mean   sd  5.5% 94.5% n_eff Rhat
a 0.32 0.09 0.18  0.46   166    1
";

# Describe the draws

describe(chn)

# End of `10/m10.01s.jl`
