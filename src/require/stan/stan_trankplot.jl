using Parameters
import StatisticalRethinking: trankplot

function trankplot(model::SampleModel, param::Symbol; bins=40)
    nt = read_samples(model, :namedtuple)
    n_draws = model.method.num_samples
    n_chains = model.n_chains[1]

    if n_chains == 1
        @warn "trankplot() needs multiple chains."
        return
    end

    if !(param in keys(nt))
        @warn "Parameter $(param) not in model."
        return
    end

   if length(size(nt[param])) > 1
        params = [Symbol("$(param)[$i]") for i in 1:size(nt[param], 1)]
        n_pars = length(params)
    else
        params = [param]
        n_pars = 1
    end

    dfs = read_summary(model)
    n_eff = dfs[indexin(params, dfs[:, :parameters]), :ess]

    trankplot(nt, param; bins=bins, n_draws=n_draws, n_chains=n_chains, n_eff=n_eff)
end
