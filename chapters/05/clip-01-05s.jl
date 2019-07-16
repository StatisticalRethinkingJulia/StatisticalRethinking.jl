using StatisticalRethinking, CmdStan
gr(size=(500,500));

ProjDir = rel_path("..", "scripts", "05")
cd(ProjDir)

wd = CSV.read(rel_path("..", "data", "WaffleDivorce.csv"), delim=';');
df = convert(DataFrame, wd);
df[:A] = scale(df[:MedianAgeMarriage]);
df[:D] = scale(df[:Divorce]);
first(df, 5)

std(df[:MedianAgeMarriage])

#=
m5.1.1 <- ulam(
    alist(
        D ~ dnorm( mu , sigma ) ,
        mu <- a + bA * A ,
        a ~ dnorm( 0 , 0.2 ) ,
        bA ~ dnorm( 0 , 0.5 ) ,
        sigma ~ dexp( 1 )
    ) , data = list(A=d$MedianAgeMarriage.s,
      D=d$Divorce.s), chain=4 )
precis(m5.1.1)
=#

ad = "
data {
 int < lower = 1 > N; // Sample size
 vector[N] D; // Outcome
 vector[N] A; // Predictor
}

parameters {
 real a; // Intercept
 real bA; // Slope (regression coefficients)
 real < lower = 0 > sigma; // Error SD
}

model {
  vector[N] mu;

  a ~ normal(0, 0.2);
  bA ~ normal(0, 0.5);
  sigma ~ exponential(1);

  mu = a + bA * A;
  D ~ normal(mu , sigma);
}
";

m5_1s = Stanmodel(name="MedianAgeDivorce", model=ad);

data = Dict("N" => length(df[:D]), "D" => df[:Divorce],
    "A" => df[:A]);

rc, chn, cnames = stan(m5_1s, data, ProjDir, diagnostics=false,
  summary=true, CmdStanDir=CMDSTAN_HOME);

describe(chn)

plot(chn)

rethinking = "
       mean   sd  5.5% 94.5% n_eff Rhat
a      9.69 0.22  9.34 10.03  2023    1
bA    -1.04 0.21 -1.37 -0.71  1882    1
sigma  1.51 0.16  1.29  1.79  1695    1
"

xi = -3.0:0.01:3.0
rws, vars, chns = size(chn)
alpha_vals = convert(Vector{Float64}, reshape(chn.value[:, 1, :], (rws*chns)))
beta_vals = convert(Vector{Float64}, reshape(chn.value[:, 2, :], (rws*chns)))
yi = mean(alpha_vals) .+ mean(beta_vals)*xi

scatter(df[:A], df[:D], color=:darkblue,
  xlab="Standardized median age of marriage",
  ylab="Standardize divorce rate")
plot!(xi, yi, lab="Regression line")

mu = link(xi, chn, [1, 2], mean(xi));
yl = [minimum(mu[i]) for i in 1:length(xi)];
yh =  [maximum(mu[i]) for i in 1:length(xi)];
ym =  [mean(mu[i]) for i in 1:length(xi)];
pi = hcat(xi, yl, ym, yh);
pi[1:5,:]

plot!((xi, yl), color=:lightgrey, leg=false)
plot!((xi, yh), color=:lightgrey, leg=false)
for i in 1:length(xi)
  plot!([xi[i], xi[i]], [yl[i], yh[i]], color=:lightgrey, leg=false)
end
scatter!(df[:A], df[:D], color=:darkblue)
plot!(xi, yi, lab="Regression line")

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

