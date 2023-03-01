using AxisKeys
import ParetoSmooth: loo_compare

function psis_loo(model::SampleModel; loglikelihood_name="loglik")
    chains = read_samples(model, :keyedarray) # Obtain KeyedArray chains
    psis_loo(chains; loglikelihood_name)
end

function psis_loo(chains::T; loglikelihood_name="loglik") where {T <: KeyedArray}
    ll = Array(matrix(chains, loglikelihood_name)) # Extract loglik matrix
    ll_p = to_paretosmooth(ll) # Permute dims for ParetoSmooth
    psis = psis_loo(ll_p) # Compute PsisLoo for model
end

# KeyedArray chains are [draws, chains, params] while ParetoSmooth
# expects [params, draws, chains].
function to_paretosmooth(ll, pd = [3, 1, 2])
    permutedims(ll, pd)
end

function loo_compare(models::Vector{SampleModel}; 
    loglikelihood_name="loglik",
    model_names=nothing,
    sort_models=true, 
    show_psis=true)

    nmodels = length(models)
    model_names = [models[i].name for i in 1:nmodels]

    chains_vec = read_samples.(models, :keyedarray) # Obtain KeyedArray chains
    loo_compare(chains_vec; loglikelihood_name, model_names, sort_models, show_psis)
end

function loo_compare(chains_vec::Vector{<: KeyedArray}; 
    loglikelihood_name="loglik",
    model_names=nothing,
    sort_models=true, 
    show_psis=true)

    nmodels = length(chains_vec)

    ll_vec = Array.(matrix.(chains_vec, loglikelihood_name)) # Extract loglik matrix
    ll_vecp = map(to_paretosmooth, ll_vec) # Permute dims for ParetoSmooth
    psis_vec = psis_loo.(ll_vecp) # Compute PsisLoo for all models

    if show_psis # If a printout is needed
        for i in 1:nmodels
            psis_vec[i] |> display
        end
    end

    loo_compare(psis_vec...; model_names, sort_models)
end

CHNS(chns::KeyedArray) = Text(sprint(show, "text/plain", chns))

export
    to_paretosmooth,
    psis_loo,
    loo_compare,
    CHNS
