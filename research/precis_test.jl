using Markdown
using InteractiveUtils

# ╔═╡ 837951f4-68ec-11eb-048d-6b27b9055428
using Pkg, DrWatson

# ╔═╡ 91489170-68ec-11eb-3611-150d5febf223
begin
    @quickactivate "StatisticalRethinking"
    using StatisticalRethinking
end

# ╔═╡ 7046ea12-68ec-11eb-18ae-a724ca79a21f
md" ## Clip-07-32-34s.jl"

# ╔═╡ ace5ed4c-68ec-11eb-05ed-1f1ff2d72e1b
begin
    df = CSV.read(sr_datadir("WaffleDivorce.csv"), DataFrame);
    scale!(df, [:Marriage, :MedianAgeMarriage, :Divorce])
    precis(df[:, [:MedianAgeMarriage, :Marriage, :Divorce]])
end;
