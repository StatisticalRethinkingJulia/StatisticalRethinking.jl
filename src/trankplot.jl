using Parameters

function rank_matrix(x::Array{Float64, 2}, nt_args::NamedTuple)
    @unpack n_draws, n_pars, n_chains = nt_args
    xc = zeros(Int, n_draws, n_pars, n_chains)
    for i in 1:n_pars
        ranked = Int.(ordinalrank(x[:, i]))
        for j in 1:n_chains
            start_draw = (j-1) * n_draws + 1
            last_draw = j * n_draws
            xc[:, i, j] = ranked[start_draw:last_draw]
        end
    end
    xc
end

function trankplot(nt::NamedTuple, param::Symbol;
        bins=40, n_draws=4000, n_chains=4, n_eff=0)

   if length(size(nt[param])) > 1
        params = [Symbol("$(param)[$i]") for i in 1:size(nt[param], 1)]
        n_pars = length(params)
    else
        params = [param]
        n_pars = 1
    end

    nt_args = (n_draws=n_draws, n_pars=n_pars, n_chains=n_chains)
    if length(params) > 1
        ranks = rank_matrix(Matrix(nt[param]'), nt_args)
    else
        ranks = rank_matrix(reshape(nt[param], length(nt[param]), 1), nt_args)
    end    

    figs = Vector{Plots.Plot{Plots.GRBackend}}(undef, length(params))
    for i in 1:length(params)
        figs[i] = stephist(ranks[:,1,1]; bins, alpha=0.9, lab="Chain 1", leg=:bottomright)
        for i in 2:n_chains
            stephist!(ranks[:,1,i]; bins, alpha=0.9, lab="Chain $i", leg=:bottomright)
        end
        title!("Trankplot for $(params[i])")
        annotate!([(30, 0, Plots.text("n_eff = $(n_eff[i])", 10, :darkred, :left))])
    end
    figs
end

export
    rank_matrix,
    trankplot