### A Pluto.jl notebook ###
# v0.11.4

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 7079ec54-d3f6-11ea-0034-79a1c1c5b137
md"# The Basel problem
_Leonard Euler_ proved in 1741 that the series
$$\frac{1}{1} + \frac{1}{4} + \frac{1}{9} + \cdots$$
converges to
$$\frac{\pi^2}{6}$$"

# ╔═╡ cce045ac-d373-11ea-29af-5be52ed80e36
md"## Test Pluto notebook"

# ╔═╡ 4d6bd562-d836-11ea-0756-11ef4bf1b67d
md"""
 [^1] footnote 1

 [^note] Footnote 2

 [^asdf]: I am a reference to asdf
"""

# ╔═╡ be082f3c-d836-11ea-0b9a-7bd30ac3939a
md"Hey I am referencing [^1], [^two] and [^another_one_here].

 [^another_one_here]: Heyy"

# ╔═╡ 82aff0b0-d7f4-11ea-0425-858a365a7bf5
using Pkg

# ╔═╡ 6d6e761e-d979-11ea-2ad8-7904c919e31f
begin
	using Pluto
	Pluto.ENV_DEFAULTS
end

# ╔═╡ 8bb02eb6-d8b5-11ea-3c96-e5722e9c771d
using PlutoUI

# ╔═╡ e290ed2e-d8b5-11ea-0307-dfd62f6f6637
using StatsPlots

# ╔═╡ 1df9a2c0-d8c5-11ea-0422-c1bf4be84abe
using Distributions

# ╔═╡ a1b39506-d278-11ea-1a13-05f75d56dbca
VERSION

# ╔═╡ 926695b4-d974-11ea-1dbd-ff56f8ab770e
Text(sprint(versioninfo))

# ╔═╡ 4f4d4b4c-d7eb-11ea-2aad-4dd2949c05e8
Text(sprint(io -> Pkg.status(io=io, "StructuralCausalModels")))

# ╔═╡ 90b4aa18-d8b5-11ea-0451-ab8a9469fc2f
@bind μ Slider(-10:10, default=0)

# ╔═╡ 77b37a66-d8c5-11ea-25b4-4fdff072ee88
@bind σ Slider(0:10, default=2)

# ╔═╡ b78c317e-d8b5-11ea-3f90-c1a334efc497
density(rand(Normal(μ, σ), 500), lab="Normal(μ=$μ, σ=$σ)")

# ╔═╡ 4c4e6dfa-d97d-11ea-3d50-5747bde72cfb
@bind vegetable Select(["potato", "carrot"])

# ╔═╡ 69ea345c-d97d-11ea-3f18-bbe58107c237
@bind debug CheckBox(default=false)

# ╔═╡ Cell order:
# ╟─7079ec54-d3f6-11ea-0034-79a1c1c5b137
# ╟─cce045ac-d373-11ea-29af-5be52ed80e36
# ╠═a1b39506-d278-11ea-1a13-05f75d56dbca
# ╠═926695b4-d974-11ea-1dbd-ff56f8ab770e
# ╠═82aff0b0-d7f4-11ea-0425-858a365a7bf5
# ╠═4f4d4b4c-d7eb-11ea-2aad-4dd2949c05e8
# ╠═6d6e761e-d979-11ea-2ad8-7904c919e31f
# ╟─4d6bd562-d836-11ea-0756-11ef4bf1b67d
# ╠═be082f3c-d836-11ea-0b9a-7bd30ac3939a
# ╠═8bb02eb6-d8b5-11ea-3c96-e5722e9c771d
# ╠═e290ed2e-d8b5-11ea-0307-dfd62f6f6637
# ╠═1df9a2c0-d8c5-11ea-0422-c1bf4be84abe
# ╠═90b4aa18-d8b5-11ea-0451-ab8a9469fc2f
# ╠═77b37a66-d8c5-11ea-25b4-4fdff072ee88
# ╠═b78c317e-d8b5-11ea-3f90-c1a334efc497
# ╠═4c4e6dfa-d97d-11ea-3d50-5747bde72cfb
# ╠═69ea345c-d97d-11ea-3f18-bbe58107c237
