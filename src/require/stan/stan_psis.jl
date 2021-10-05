import ParetoSmooth: psis_loo, loo_compare
import ParetoSmoothedImportanceSampling: psisloo, waic

function psisloo(m::SampleModel, wcpp::Int64=20, wtrunc::Float64=3/4)
    nt = read_samples(m, :namedtuple)
    if :log_lik in keys(nt)
        lp = Matrix(nt.log_lik')
    else
        @warn "Model $(m.name) does not compute a log_lik matrix."
    end

    psisloo(lp, wcpp, wtrunc)
end

function waic(m::SampleModel; pointwise=false)
    nt = read_samples(m, :namedtuple)
    if :log_lik in keys(nt)
        lp = Matrix(nt.log_lik')
    else
        @warn "Model $(m.name) does not compute a log_lik matrix."
    end

    waic(lp; pointwise)
end


function psis_loo(model::SampleModel; loglikelihood_name="log_lik")
    chains = read_samples(model) # Obtain KeyedArray chains
    psis_loo(chains; loglikelihood_name)
end

function psis_loo(chains::T; loglikelihood_name="log_lik") where {T <: KeyedArray}
    ll = Array(matrix(chains, loglikelihood_name)) # Extract log_lik matrix
    ll_p = to_paretosmooth(ll) # Permute dims for ParetoSmooth
    psis = psis_loo(ll_p) # Compute PsisLoo for model
end

# KeyedArray chains are [draws, chains, params] while ParetoSmooth
# expects [params, draws, chains].
function to_paretosmooth(ll, pd = [3, 1, 2])
    permutedims(ll, pd)
end

function loo_compare(models::Vector{SampleModel}; 
    loglikelihood_name="log_lik",
    model_names=nothing,
    sort_models=true, 
    show_psis=true)

    nmodels = length(models)
    model_names = [models[i].name for i in 1:nmodels]

    chains_vec = read_samples.(models) # Obtain KeyedArray chains
    loo_compare(chains_vec; loglikelihood_name, model_names, sort_models, show_psis)
end

function loo_compare(chains_vec::Vector{<: KeyedArray}; 
    loglikelihood_name="log_lik",
    model_names=nothing,
    sort_models=true, 
    show_psis=true)

    nmodels = length(chains_vec)

    ll_vec = Array.(matrix.(chains_vec, loglikelihood_name)) # Extract log_lik matrix
    ll_vecp = map(to_paretosmooth, ll_vec) # Permute dims for ParetoSmooth
    psis_vec = psis_loo.(ll_vecp) # Compute PsisLoo for all models

    if show_psis # If a printout is needed
        for i in 1:nmodels
            psis_vec[i] |> display
        end
    end

    loo_compare(psis_vec...; model_names, sort_models)
end

export
    to_paretosmooth,
    waic,
    psis_loo,
    loo_compare