using .StanOptimize
using .StanSample

import StatisticalRethinking: quap

function quap(
    name::AbstractString,
    model::AbstractString;
    kwargs...)

    sm = SampleModel(name, model)
    rc = stan_sample(sm; kwargs...)
    if success(rc)
        om = OptimizeModel(name*"_opt", model)
        rc2 = stan_optimize(om; kwargs...)
    else
        return ((nothing, nothing, nothing))
    end
    if success(rc2)
        qm = quap(sm , om; kwargs...)
        return ((qm, sm, om))
    else
        return ((nothing, sm, nothing))
    end
end

function quap(
    sm_sam::SampleModel, 
    sm_opt::OptimizeModel;
    kwargs...)

    samples = read_samples(sm_sam; output_format=:dataframe)
    optim, cnames = read_optimize(sm_opt)
  
    ntnames = (:coef, :vcov, :converged, :distr, :params)
    dct = Dict(kwargs)
    #if :init in keys(dct)
    #    n = Symbol.(keys(dct[:init]))
    #else
        n = Symbol.(names(samples))
    #end
    coefnames = tuple(n...,)
    c = [optim[String(coefname)][1] for coefname in coefnames]
    cvals = reshape(c, 1, length(n))
    coefvalues = reshape(c, length(n))
    the_keys = [k for k in n]
    v = Statistics.covm(Array(samples[:, the_keys]), cvals)

    distr = if length(coefnames) == 1
        Normal(coefvalues[1], √v[1])  # Normal expects stddev
    else
        MvNormal(coefvalues, v)       # MvNormal expects variance matrix
    end

    converged = true
    for coefname in coefnames
        o = optim[String(coefname)]
        converged = abs(sum(o) - 4 * o[1]) < 0.001 * abs(o[1])
        !converged && break
    end
    ntvalues = tuple(
        namedtuple(coefnames, coefvalues),
            v, converged, distr, n
    )
    
    namedtuple(ntnames, ntvalues)
end

export
  quap
