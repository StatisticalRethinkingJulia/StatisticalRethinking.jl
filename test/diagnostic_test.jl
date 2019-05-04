using CmdStan, Turing
using StatsPlots, Random, MCMCDiagnostics

Random.seed!(12395391)

ProjDir = @__DIR__
cd(ProjDir)

Nsamples = 2000
Nadapt = 1000
N = 30
data = Dict("y" => rand(Normal(0,1),N),
  "N" => N)

  normstanmodel = "
  data {
    int<lower=0> N;
    vector[N] y;
  }
  parameters {
    real mu;
    real<lower=0> sigma;
  }
  model {
    mu ~ normal(0,1);
    sigma ~ cauchy(0,5);
    y ~ normal(mu,sigma);
  }
  "

 @model model(y) = begin
     μ ~ Normal(0,1)
     σ ~ Truncated(Cauchy(0,5),0,Inf)
     for n = 1:length(y)
         y[n] ~ Normal(μ,σ)
     end
 end

 stanmodel = Stanmodel(
    name = "normstanmodel", model = normstanmodel, nchains = 4,
    Sample(num_samples = Nsamples-Nadapt, num_warmup = Nadapt, adapt = CmdStan.Adapt(delta=0.8)
      ,save_warmup = false));

series = []
 initOutput() = DataFrame(μ=Float64[],σ=Float64[])
 ess_array_cmdstan = initOutput()
 ess_array_MCMCChains_cmdstan = initOutput()
 ess_array_MCMCDiagnostics_cmdstan = initOutput()
 ess_array_MCMCChains_turing = initOutput()
 ess_array_MCMCDiagnostics_turing = initOutput()

 rhat_array_cmdstan = initOutput()
 rhat_array_MCMCChains_turing = initOutput()
 rhat_array_MCMCChains_cmdstan = initOutput()

 for i in 1:100
   chn = mapreduce(x->sample(model(data["y"]),
     NUTS(Nsamples, Nadapt, 0.8)), chainscat, 1:4)
     
   dft = describe(chn[(Nadapt+1):end,:,:])[1]
   push!(ess_array_MCMCChains_turing, dft[:ess])
   push!(rhat_array_MCMCChains_turing, dft[:r_hat])
   
   rc, chns, cnames = stan(stanmodel,data, summary=true, ProjDir)
   dfc = describe(chns)[1]
   
   push!(ess_array_MCMCChains_cmdstan, dfc[:ess])
   push!(rhat_array_MCMCChains_cmdstan, dfc[:r_hat])
   
   cdf = read_summary(stanmodel, ProjDir)
   push!(ess_array_cmdstan, cdf[[:mu, :sigma], :ess])
   push!(rhat_array_cmdstan, cdf[[:mu, :sigma], :r_hat])
   
   ac = DataFrame(chns);
   at = DataFrame(chn[1001:2000,:,:]);
   push!(ess_array_MCMCDiagnostics_cmdstan,
    [effective_sample_size(ac[:mu]), 
     effective_sample_size(ac[:sigma])])
   push!(ess_array_MCMCDiagnostics_turing,
     [effective_sample_size(at[:μ]), 
      effective_sample_size(at[:σ])])
 end

p = Array{Plots.Plot{Plots.GRBackend}}(undef, 3);
p[1] = plot(convert(Vector{Float64}, ess_array_cmdstan[:μ]), 
  lab="CmdStan", xlim=(0, 200), title=":mu ess")
p[1] = plot!(convert(Vector{Float64}, ess_array_MCMCChains_cmdstan[:μ]), 
  lab="MCMCChains/CmdStan ess")
p[1] = plot!(convert(Vector{Float64}, ess_array_MCMCDiagnostics_cmdstan[:μ]), 
  lab="MCMCDiagnostics/CmdStan ess")
p[1] = plot!(convert(Vector{Float64}, ess_array_MCMCChains_turing[:μ]), 
  lab="MCMCChains/Turing ess")
p[1] = plot!(convert(Vector{Float64}, ess_array_MCMCDiagnostics_turing[:μ]), 
  lab="MCMCDiagnostics/Turing")
  
p[2] = plot(convert(Vector{Float64}, ess_array_cmdstan[:μ]), 
  lab="CmdStan", xlim=(0, 200))
p[2] = plot!(convert(Vector{Float64}, ess_array_MCMCChains_cmdstan[:μ]), 
  lab="MCMCChains/CmdStan ess")
p[2] = plot!(convert(Vector{Float64}, ess_array_MCMCDiagnostics_cmdstan[:μ]), 
  lab="MCMCDiagnostics/CmdStan ess")
  
p[3] = plot(convert(Vector{Float64}, ess_array_MCMCChains_turing[:μ]), 
  lab="MCMCChains/Turing ess",
  xlim=(0, 200))
p[3] = plot!(convert(Vector{Float64}, ess_array_MCMCDiagnostics_turing[:μ]),
   lab="MCMCDiagnostics/Turing ess")
plot(p..., layout=(3,1))
savefig("ess_mu__estimates_plot.pdf")

p = Array{Plots.Plot{Plots.GRBackend}}(undef, 3);
p[1] = plot(convert(Vector{Float64}, ess_array_cmdstan[:σ]), 
  lab="CmdStan", xlim=(0, 200), title=":sigma ess")
p[1] = plot!(convert(Vector{Float64}, ess_array_MCMCChains_cmdstan[:σ]), 
  lab="MCMCChains/CmdStan ess")
p[1] = plot!(convert(Vector{Float64}, ess_array_MCMCDiagnostics_cmdstan[:σ]), 
  lab="MCMCDiagnostics/CmdStan ess")
p[1] = plot!(convert(Vector{Float64}, ess_array_MCMCChains_turing[:σ]), 
  lab="MCMCChains/Turing ess")
p[1] = plot!(convert(Vector{Float64}, ess_array_MCMCDiagnostics_turing[:σ]), 
  lab="MCMCDiagnostics/Turing")
  
p[2] = plot(convert(Vector{Float64}, ess_array_cmdstan[:σ]), 
  lab="CmdStan", xlim=(0, 200))
p[2] = plot!(convert(Vector{Float64}, ess_array_MCMCChains_cmdstan[:σ]), 
  lab="MCMCChains/CmdStan ess")
p[2] = plot!(convert(Vector{Float64}, ess_array_MCMCDiagnostics_cmdstan[:σ]), 
  lab="MCMCDiagnostics/CmdStan ess")
  
p[3] = plot(convert(Vector{Float64}, ess_array_MCMCChains_turing[:σ]), 
  lab="MCMCChains/Turing ess",
  xlim=(0, 200))
p[3] = plot!(convert(Vector{Float64}, ess_array_MCMCDiagnostics_turing[:σ]),
   lab="MCMCDiagnostics/Turing ess")
plot(p..., layout=(3,1))
savefig("ess_sigma__estimates_plot.pdf")

q = Array{Plots.Plot{Plots.GRBackend}}(undef, 2);
q[1] = plot(convert(Vector{Float64}, rhat_array_cmdstan[:μ]),
  lab="CmdStan r_hat", xlim=(0, 200), title=":mu r_hat")
q[1] = plot!(convert(Vector{Float64}, rhat_array_MCMCChains_cmdstan[:μ]), 
  line=(:dash), lab="MCMCChains/CmdStan r_hat")
q[1] = plot!(convert(Vector{Float64}, rhat_array_MCMCChains_turing[:μ]), 
  lab="MCMCChains/Turing r_hat")
q[2] = plot(convert(Vector{Float64}, rhat_array_cmdstan[:μ]), 
  lab="CmdStan r_hat", xlim=(0, 200))
q[2] = plot!(convert(Vector{Float64}, rhat_array_MCMCChains_cmdstan[:μ]),
  line=(:dash), lab="MCMCChains/CmdStan r_hat")
plot(q..., layout=(2,1))
savefig("rhat_mu__estimates_plot.pdf")

q = Array{Plots.Plot{Plots.GRBackend}}(undef, 2);
q[1] = plot(convert(Vector{Float64}, rhat_array_cmdstan[:σ]),
  lab="CmdStan r_hat", xlim=(0, 200), title=":sigma r_hat")
q[1] = plot!(convert(Vector{Float64}, rhat_array_MCMCChains_cmdstan[:σ]), 
  line=(:dash), lab="MCMCChains/CmdStan r_hat")
q[1] = plot!(convert(Vector{Float64}, rhat_array_MCMCChains_turing[:σ]), 
  lab="MCMCChains/Turing r_hat")
q[2] = plot(convert(Vector{Float64}, rhat_array_cmdstan[:σ]), 
  lab="CmdStan r_hat", xlim=(0, 200))
q[2] = plot!(convert(Vector{Float64}, rhat_array_MCMCChains_cmdstan[:σ]),
  line=(:dash), lab="MCMCChains/CmdStan r_hat")
plot(q..., layout=(2,1))
savefig("rhat_sigma_estimates_plot.pdf")
