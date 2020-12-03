using .StanOptimize
using .StanSample

import StatisticalRethinking: quap

function quap(sm_sam::SampleModel, sm_opt::OptimizeModel)
    samples = read_samples(sm_sam; output_format=:dataframe)
    optim, cnames = read_optimize(sm_opt)
  
    ntnames = (:coef, :vcov, :converged, :distr, :params)
    n = Symbol.(names(samples))
    coefnames = tuple(n...,)
    c = [optim[String(coefname)][1] for coefname in coefnames]
    cvals = reshape(c, 1, length(n))
    coefvalues = reshape(c, length(n))
    v = Statistics.covm(Array(samples), cvals)

    distr = if length(coefnames) == 1
        Normal(coefvalues[1], √v[1])  # Normal expects stddev
    else
        MvNormal(coefvalues, v)       # MvNormal expects variance matrix
    end

    converged = true
    for coefname in coefnames
        o = optim[String(coefname)]
        converged = abs(sum(o) - 4 * o[1]) < 0.001 * o[1]
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
