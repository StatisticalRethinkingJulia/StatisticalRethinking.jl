using StatisticalRethinking, CmdStan
#gr(size=(600,600));

ProjDir = rel_path("..", "scripts", "04")

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

df2 = filter(row -> row[:age] >= 18, df)
first(df2, 5)

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

stanmodel = Stanmodel(name="heights", model=heightsmodel);

heightsdata = Dict("N" => length(df2[:height]), "h" => df2[:height]);

rc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME);

MCMCChains.describe(chn)

serialize("m4.1s.jls", chn)
chn2 = deserialize("m4.1s.jls")

MCMCChains.describe(chn2)

# end of m4.1s