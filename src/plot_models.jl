function  plot_models(df::DataFrame, type = :waic;
    fig = "", title)

    models = size(df, 1)
    colors = [:blue, :red, :green, :darkred, :black]

    pars = ["dSE", "WAIC"]

    xmin = 0.95min(minimum(df.WAIC), minimum(df.lppd))
    xmax = 1.1max(maximum(df.WAIC), maximum(df.lppd))
    for r in eachrow(df)
        oos = r.WAIC
        xmin = min(xmin, oos - r.SE)
        xmax = max(xmax, oos + r.SE)
    end

    ylabs = String[]
    for j in 1:models
        l = length(df.models[j])
        str = df.models[j] * repeat(" ", 9-l)
        append!(ylabs, [str])
        for i in 1:2
            l = length(String(pars[i]))
            str = repeat(" ", 9-l) * String(pars[i])
            append!(ylabs, [str])
        end
    end
    reverse!(ylabs)

    ys = [string(ylabs[i]) for i = 1:length(ylabs)]
    p = plot(xlims=(xmin, xmax), leg=false, framestyle=:grid)
    title!(title)
    yran = range(1, stop=length(ylabs), length=length(ys))
    yticks!(yran, ys)

    line = 0
    for r in reverse(eachrow(df))
        line += 1
        hline!([line] .+ length(pars), color=:darkgrey, line=(2, :dash))
        for i in 1:2
            line += 1
            if i == 1
                syms = Symbol.(pars[i])
                ypos = line - 1
                oos = r.WAIC
                lower = oos - r.SE
                upper = oos + r.SE
                plot!([lower, upper], [ypos, ypos], leg=false, color=:black)
                scatter!([oos], [ypos], color=:darkred, markersize=8)
                scatter!([r.lppd], [ypos], color=:darkblue)
            else
                syms = Symbol.(pars[i])
                ypos = line - 1
                is = r.WAIC
                lower = is - r.dSE
                upper = is + r.dSE
                if r.dSE > 0
                    plot!([lower, upper], [ypos, ypos], leg=false, color=:grey)
                    scatter!([is], [ypos], color=:lightgrey,
                        marker = ([:utriangle], 8, 0.8, Plots.stroke(3, :gray)))
                end
            end
        end
     end
    p
end

export
    plot_models