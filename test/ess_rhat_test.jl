using CmdStan, Turing
using StatsPlots, Random, MCMCDiagnostics

Random.seed!(12395391)

ProjDir = @__DIR__
cd(ProjDir)

berstanmodel = "
data { 
  int<lower=0> N; 
  int<lower=0,upper=1> y[N];
} 
parameters {
  real<lower=0,upper=1> theta;
} 
model {
  theta ~ beta(1,1);
  for (n in 1:N) 
    y[n] ~ bernoulli(theta);
}
"

data = Dict("y" => [0,1,0,0,0,0,0,0,0,1],
  "N" => 10)

stanmodel = Stanmodel(
   name = "berstanmodel", model = berstanmodel, nchains = 4);


@model bermodel(y) = begin
    theta ~ Beta(1,1)
    for n = 1:length(y)
        y[n] ~ Bernoulli(theta)
    end
end

ess_array_MCMCChains_turing = []
ess_array_MCMCChains_cmdstan = []
ess_array_cmdstan = []
ess_array_dHMC_cmdstan = []
ess_array_dHMC_turing = []

rhat_array_MCMCChains_turing = []
rhat_array_MCMCChains_cmdstan = []
rhat_array_cmdstan = []

for i in 1:100
  chn = mapreduce(x->sample(bermodel([0,1,0,0,0,0,0,0,0,1]),
    NUTS(2000, 1000, 0.95)), chainscat, 1:4)
  dft = describe(chn[1001:2000,:,:])[1]
  append!(ess_array_MCMCChains_turing, dft[:theta, :ess])
  append!(rhat_array_MCMCChains_turing, dft[:theta, :r_hat])
  rc, chns, cnames = stan(stanmodel,
     data, summary=true, ProjDir);
  dfc = describe(chns)[1]
  append!(ess_array_MCMCChains_cmdstan, dfc[:theta, :ess])
  append!(rhat_array_MCMCChains_cmdstan, dfc[:theta, :r_hat])
  cdf = read_summary(stanmodel, ProjDir)
  append!(ess_array_cmdstan, cdf[:theta, :ess])
  append!(rhat_array_cmdstan, cdf[:theta, :r_hat])
  
  
  ac = Array(chns);
  at = Array(chn[1001:2000,:,:]);
  append!(ess_array_dHMC_cmdstan, effective_sample_size(ac))
  append!(ess_array_dHMC_turing, effective_sample_size(at))
end

[mean(ess_array_MCMCChains_turing),
  std(ess_array_MCMCChains_turing)] |> display
[mean(ess_array_cmdstan), std(ess_array_cmdstan)] |> display
[mean(ess_array_MCMCChains_cmdstan), 
  std(ess_array_MCMCChains_cmdstan)] |> display
[mean(ess_array_dHMC_turing), std(ess_array_dHMC_turing)] |> display
[mean(ess_array_dHMC_cmdstan), std(ess_array_dHMC_cmdstan)] |> display

p = Array{Plots.Plot{Plots.GRBackend}}(undef, 3);
p[1] = plot(ess_array_cmdstan, lab="CmdStan", xlim=(0, 200))
p[1] = plot!(ess_array_MCMCChains_cmdstan, lab="MCMCChains/CmdStan ess")
p[1] = plot!(ess_array_dHMC_cmdstan, lab="dHMC/CmdStan ess")
p[1] = plot!(ess_array_MCMCChains_turing, lab="MCMCChains/Turing ess")
p[1] = plot!(ess_array_dHMC_turing, lab="dHMC/Turing")
p[2] = plot(ess_array_cmdstan, lab="CmdStan", xlim=(0, 200))
p[2] = plot!(ess_array_MCMCChains_cmdstan, lab="MCMCChains/CmdStan ess")
p[2] = plot!(ess_array_dHMC_cmdstan, lab="dHMC/CmdStan ess")
p[3] = plot(ess_array_MCMCChains_turing, lab="MCMCChains/Turing ess",
  xlim=(0, 200))
p[3] = plot!(ess_array_dHMC_turing, lab="dHMC/Turing ess")
plot(p..., layout=(3,1))
savefig("ess__estimates_plot.pdf")


q = Array{Plots.Plot{Plots.GRBackend}}(undef, 2);
q[2] = plot(rhat_array_cmdstan, lab="CmdStan r_hat", xlim=(0, 200))
q[2] = plot!(rhat_array_MCMCChains_cmdstan, line=(:dash),
lab="MCMCChains/CmdStan r_hat")
q[1] = plot(rhat_array_cmdstan, lab="CmdStan r_hat", xlim=(0, 200))
q[1] = plot!(rhat_array_MCMCChains_cmdstan, line=(:dash),
lab="MCMCChains/CmdStan r_hat")
q[1] = plot!(rhat_array_MCMCChains_turing, lab="MCMCChains/Turing r_hat")
plot(q..., layout=(2,1))
savefig("rhat__estimates_plot.pdf")

