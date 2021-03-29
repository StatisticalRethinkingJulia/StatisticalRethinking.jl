function plot_logistic_coef(df::DataFrame, pars::Vector{Symbol}, mname="";
    fig="", title="")

    name = deepcopy(mname)
    if length(name) > 9
      name = name[1:9]
    end

    s = Vector{NamedTuple}(undef, length(pars))
    mindx = 1
    dftmp = DataFrame()
    for par in pars
        dftmp[!, par] = logistic.(df[:, par])
    end
    
    m, l, u = estimparam(dftmp)
    d = Dict{Symbol, NamedTuple}()
    for (indx, par) in enumerate(pars)
        d[Symbol(par)] = (mean=m[indx], lower=l[indx], upper=u[indx])
    end
    s =   (; d...)

    plot_model_coef(NamedTuple[s], pars; mnames=[name])
end

export
    plot_logistic_coef