function quap(df::DataFrame)

	d = Dict{Symbol, typeof(Particles(size(df, 1), Normal(0.0, 1.0)))}()

	for var in names(df)
		dens = kde(df[:, var])
		mu = collect(dens.x)[findmax(dens.density)[2]]
		sigma = std(df[:, var], mean=mu)
		d[var] = Particles(size(dfsa, 1), Normal(mu, sigma))
	end

	d

end
