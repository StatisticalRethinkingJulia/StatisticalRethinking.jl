using .MCMCChains

function convert_a3d(a3d_array, cnames, ::Val{:mcmcchains}; start=1, kwargs...)
  cnames = String.(cnames)
  pi = filter(p -> length(p) > 2 && p[end-1:end] == "__", cnames)
  p = filter(p -> !(p in  pi), cnames)

  MCMCChains.Chains(a3d_array,
    cnames,
    Dict(
      :parameters => p,
      :internals => pi
    );
    start=start
  )
end

 function create_mcmcchains(a3d, cnames;start=1)
   Chains(a3d, cnames; start=start)
 end
 
 function create_mcmcchains(a3d, cnames, sections::Dict{Symbol, Vector{String}};
   start=1)
   Chains(a3d, cnames, sections; start=start)
 end
