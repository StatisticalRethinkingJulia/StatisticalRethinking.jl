"""

# compare

Compare waic and psis values for models.

$(SIGNATURES)

### Required arguments
```julia
* `models`                              : Vector of SampleModels
* `type`                                : Either :waic or :psis
```
### Return values
```julia
* `df`                                 : DataFrame with statistics
```

"""
function compare(models::Vector{SampleModel}, type::Symbol)
    mnames = AbstractString[]
    lps = Matrix{Float64}[]
    for m in models
        nt = read_samples(m, :namedtuple)
        if :loglik in keys(nt)
            append!(mnames, [m.name])
            append!(lps, [Matrix(nt.loglik')])
        else
            @warn "Model $(m.name) does not produce a loglik matrix."
        end
    end
    compare(lps, type; mnames)
end
