using StatisticalRethinking
using CmdStan, StanMCMCChain
gr(size=(500,500));

ProjDir = rel_path("..", "scripts", "08")
cd(ProjDir)

N = 100                                                    # individuals
height  = rand(Normal(10,2), N) ;              # sim total height of each
leg_prop = rand(Uniform(0.4,0.5), N);      # leg as proportion of height

leg_left = leg_prop .* height .+  rand(Normal( 0 , 0.02 ), N);

leg_right = leg_prop .* height .+  rand(Normal( 0 , 0.02 ), N);

df =  DataFrame(height=height, leg_left = leg_left, leg_right = leg_right);

first(df, 5)

m_5_8_model = "
data{
    int N;
    real height[N];
    real leg_right[N];
    real leg_left[N];
}
parameters{
    real a;
    real bl;
    real br;
    real sigma;
}
model{
    vector[N] mu;
    sigma ~ cauchy( 0 , 1 );
    br ~ normal( 2 , 10 );
    bl ~ normal( 2 , 10 );
    a ~ normal( 10 , 100 );
    for ( i in 1:100 ) {
        mu[i] = a + bl * leg_left[i] + br * leg_right[i];
    }
    height ~ normal( mu , sigma );
}
";

stanmodel = Stanmodel(name="m_5_8_model", monitors = ["a", "br", "bl", "sigma"],
  model=m_5_8_model, output_format=:mcmcchain);

m_8_8_data = Dict("N" => size(df, 1), "height" => df[:height],
    "leg_left" => df[:leg_left], "leg_right" => df[:leg_right]);

rc, chn, cnames = stan(stanmodel, m_8_8_data, ProjDir, diagnostics=false,
  summary=false, CmdStanDir=CMDSTAN_HOME);

describe(chn)

plot(chn)

autocorplot(chn)

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

