"""

# coeftab_plot

Display plot with model coefficients

$(SIGNATURES)

# Arguments
- `dfs::DataFrame`: list of dataframes with sampled model parameters
- `pars`: list of column names (as symbols) to analyze. If not given, take all columns
- `pars_names`: list of strings to be used instead of column names
- `names`: list of dataframe names to be used in plot. If not given, "1", "2", "3"... will be used
- `perc_prob`: probability for confidence interval calculation

# Examples
```julia
coeftab_plots(m5_1_df, m5_2_df, m5_3_df; pars=(:bA, :bM), names=["m5.1", "m5.2", "m5.3"])
```
"""
function coeftab_plot(dfs::DataFrame...; pars=missing, pars_names=missing, names=missing, perc_prob=0.89)::Plots.Plot
    if ismissing(pars)
        pars = unique(Iterators.flatten(propertynames.(dfs)))
        sort!(pars)
    end
    if ismissing(names)
        names = string.(Base.OneTo(length(dfs)))
    end
    if ismissing(pars_names)
        pars_names = string.(pars)
    end

    x = Vector{Float64}()
    xerr = Vector{Tuple{Float64,Float64}}()
    y = Vector{String}()
    for (p_name, p) ∈ zip(pars_names, pars)
        for (name, df) ∈ zip(names, dfs)
            p ∈ propertynames(df) || continue
            μ = mean(df[!,p])
            err = abs.(PI(df[!,p], prob=perc_prob) .- μ)
            pushfirst!(x, μ)
            label = length(dfs) == 1 ? "$p_name" : "$p_name: $name"
            pushfirst!(y, label)
            pushfirst!(xerr, Tuple(err))
        end
    end
    scatter(x, y; xerr=xerr)
end

export
    coeftab_plot
