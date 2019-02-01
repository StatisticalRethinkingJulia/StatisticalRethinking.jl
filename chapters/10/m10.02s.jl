using StatisticalRethinking
using CmdStan, StanMCMCChain
gr(size=(500,500));

ProjDir = rel_path("..", "scripts", "08")
cd(ProjDir)

d = CSV.read(rel_path("..", "data", "chimpanzees.csv"), delim=';');
df = convert(DataFrame, d);

first(df, 5)

m_10_02_model = "
data{
    int N;
    int pulled_left[N];
    int prosoc_left[N];
}
parameters{
    real a;
    real bp;
}
model{
    vector[N] p;
    bp ~ normal( 0 , 10 );
    a ~ normal( 0 , 10 );
    for ( i in 1:N ) {
        p[i] = a + bp * prosoc_left[i];
        p[i] = inv_logit(p[i]);
    }
    pulled_left ~ binomial( 1 , p );
}
";

stanmodel = Stanmodel(name="m_10_02_model",
monitors = ["a", "bp"],
model=m_10_02_model, output_format=:mcmcchain);

m_10_02_data = Dict("N" => size(df, 1),
"pulled_left" => df[:pulled_left], "prosoc_left" => df[:prosoc_left]);

rc, chn, cnames = stan(stanmodel, m_10_02_data, ProjDir, diagnostics=false,
  summary=false, CmdStanDir=CMDSTAN_HOME);

m_10_2s_result = "
Iterations = 1:1000
Thinning interval = 1
Chains = 1,2,3,4
Samples per chain = 1000

Empirical Posterior Estimates:
      Mean        SD       Naive SE       MCSE      ESS
 a 0.05103234 0.12579086 0.0019889282 0.0035186307 1000
bp 0.55711212 0.18074275 0.0028577937 0.0040160451 1000

Quantiles:
       2.5%        25.0%       50.0%      75.0%      97.5%
 a -0.19755400 -0.029431425 0.05024655 0.12978825 0.30087758
bp  0.20803447  0.433720250 0.55340400 0.67960975 0.91466915
";

describe(chn)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

