import ParetoSmooth: loo_compare

function waic(m::SampleModel; pointwise=false)
    nt = read_samples(m, :namedtuple)
    if :log_lik in keys(nt)
        lp = Matrix(nt.log_lik')
    else
        @warn "Model $(m.name) does not compute a log_lik matrix."
    end

    waic(lp; pointwise)
end

function loo_compare(models::Vector{SampleModel}; 
    loglikelihood_name="log_lik", model_names=nothing, sort_models=true)

    if isnothing(model_names)
        mnames = [models[i].name for i in 1:length(models)]
    end

    nmodels = length(models)

    ka = Vector{KeyedArray}(undef, nmodels)
    ll = Vector{Array{Float64, 3}}(undef, nmodels)

    for i in 1:length(models)
        ka[i] = read_samples(models[i], :keyedarray)
        ll[i] = permutedims(Array(matrix(ka[i], loglikelihood_name)), [3, 1, 2])
    end

    loo_compare(ll; model_names=mnames, sort_models)
end


export
    psisloo,
    waic,
    loo_compare