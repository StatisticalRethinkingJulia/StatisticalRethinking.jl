import StatsModelComparisons: psisloo, waic

function psisloo(m::SampleModel, wcpp::Int64=20, wtrunc::Float64=3/4)
    nt = read_samples(m)
    if :log_lik in keys(nt)
        lp = Matrix(nt.log_lik')
    else
        @warn "Model $(m.name) does not compute a log_lik matrix."
    end

    psisloo(lp, wcpp, wtrunc)
end

function waic( m::SampleModel; pointwise=false , log_lik="log_lik" , kwargs... )
    nt = read_samples(m)
    if :log_lik in keys(nt)
        lp = Matrix(nt.log_lik')
    else
        @warn "Model $(m.name) does not compute a log_lik matrix."
    end

    waic(lp; pointwise, log_lik, kwargs)
end