using StatisticalRethinking, CmdStan, StanMCMCChain, JLD
gr(size=(500,500));

ProjDir = rel_path("..", "scripts", "04")
cd(ProjDir)

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

stanmodel = Stanmodel(name="heights", monitors = ["mu", "sigma"],model=heightsmodel,
  output_format=:mcmcchain);

heightsdata = Dict("N" => length(df2[:height]), "h" => df2[:height]);

rc, chn, cnames = stan(stanmodel, heightsdata, ProjDir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME);

describe(chn)

JLD.save("m4.1s.jld", 
  "range", chn.range, 
  "a3d", chn.value,
  "names", chn.names, 
  "chains", chn.chains)
    
d = JLD.load(joinpath(ProjDir, "m4.1s.jld"))

chn2 = MCMCChain.Chains(d["a3d"], names=d["names"])
describe(chn2)

# end of m4.1s