function pk_qualify(pk::Vector{Float64})
    pk_good = sum(pk .<= 0.5)
    pk_ok = length(pk[pk .<= 0.7]) - pk_good
    pk_bad = length(pk[pk .<= 1]) - pk_good - pk_ok
    (good=pk_good, ok=pk_ok, bad=pk_bad, very_bad=sum(pk .> 1))
end

@userplot Pk_Plot

@recipe function f(p::Pk_Plot)
    if length(p.args) != 1 || !(p.args[1] isa AbstractVector{<:Real})
        error("PSIS diagnostic plots should be given one vector. Got: ", typeof(p.args))
    end
    pk = p.args[1]

    # default plotting attributes
    title --> "PSIS diagnostic plot"
    legend --> :topleft
    xguide --> "Datapoint"
    yguide --> "Pareto shape k"

    @series begin
        seriestype := :scatter
        marker --> 2.5
        label := "Pk points"
        pk
    end

    @series begin
        seriestype := :hline
        label := "pk = 0.5"
        [0.5]
    end

    @series begin
        seriestype := :hline
        label := "pk = 0.7"
        [0.7]
    end

    @series begin
        seriestype := :hline
        label := "pk = 1.0"
        [1.0]
    end
end

export
    pk_qualify,
    pk_plot
    