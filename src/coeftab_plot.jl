"""

# coeftab_plot

Display plot with model coefficients

$(SIGNATURES)

# Arguments
- `dfs::DataFrame`: list of dataframes with sampled model parameters
- `pars`: list of column names (as symbols) to analyze. If not given, take all columns
- `names`: list of dataframe names to be used in plot. If not given, "1", "2", "3"... will be used

# Examples
```julia
coeftab_plots(m5_1_df, m5_2_df, m5_3_df; pars=(:bA, :bM), names=["m5.1", "m5.2", "m5.3"])
```
"""
using Base.Iterators: Iterators

function coeftab_plot(dfs::DataFrame...; pars=missing, names=missing)::Plots.Plot
    if ismissing(pars)
        pars = unique(Iterators.flatten(propertynames.(dfs)))
        sort!(pars)
    end
    if ismissing(names)
        names = string.(Base.OneTo(length(dfs)))
    end

    x = Vector{Float64}()
    xerr = Vector{Float64}()
    y = Vector{String}()
    for p ∈ pars
        for (name, df) ∈ zip(names, dfs)
            p ∈ propertynames(df) || continue
            (μ, σ) = mean_and_std(df[!,p])
            pushfirst!(x, μ)
            pushfirst!(y, "$p: $name")
            pushfirst!(xerr, σ)
        end
    end
    scatter(x, y; xerr=xerr)
end

export
    coeftab_plot
