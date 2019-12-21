"""

# quap

Quadratic approximation of a posterior distribution

### Method
```julia
quap(df) 
```

### Required arguments
```julia
* `df::DataFrame`               : Dataframe generated from a chain
```

### Return values
```julia
* `result::Dict`                : Dictionary summarizing approximation
```

### Example
```julia

# Run stan_sample() on a SampleModel

if sample_file !== nothing
	
	chn = read_samples(sm)
	quap(DataFrame(chn))

end

```

"""
function quap(df::DataFrame)

	d = Dict{Symbol, typeof(Particles(size(df, 1), Normal(0.0, 1.0)))}()

	for var in names(df)
		dens = kde(df[:, var])
		mu = collect(dens.x)[findmax(dens.density)[2]]
		sigma = std(df[:, var], mean=mu)
		d[var] = Particles(size(df, 1), Normal(mu, sigma))
	end

	d

end
