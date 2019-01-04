using StatisticalRethinking, CmdStan, StanMCMCChain
gr(size=(500,500));

ProjDir = rel_path("..", "chapters", "04")
cd(ProjDir)

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

df2 = filter(row -> row[:age] >= 18, df)
female_df = filter(row -> row[:male] == 0, df2)
male_df = filter(row -> row[:male] == 1, df2)
first(male_df, 5)

density(df2[:height], lab="All heights", xlab="height [cm]", ylab="density")

density!(female_df[:height], lab="Female heights")
density!(male_df[:height], lab="Male heights")

heightsmodel = "
// Inferring a Rate
data {
  int N;
  real<lower=0> h[N];
}
parameters {
  real<lower=0> sigma;
  real<lower=0,upper=250> mu;
}
model {
  // Priors for mu and sigma
  mu ~ normal(178, 20);
  sigma ~ uniform( 0 , 50 );

  // Observed heights
  h ~ normal(mu, sigma);
}
";

stanmodel = Stanmodel(name="heights", monitors = ["mu", "sigma"],model=heightsmodel,
  output_format=:mcmcchain);

heightsdata = Dict("N" => length(df2[:height]), "h" => df2[:height]);

rc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME);

describe(chn)

density(chn, lab="All heights", xlab="height [cm]", ylab="density")

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

