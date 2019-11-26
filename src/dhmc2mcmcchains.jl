import MCMCChains: Chains

function create_a3d(noofsamples, noofvariables, noofchains)
   a3d = fill(0.0, noofsamples, noofvariables, noofchains)
   a3d
 end
 
 function insert_chain!(a3d, chain, posterior, trans)
   for i in 1:size(a3d, 1)
     a3d[i,:,chain] = inverse(trans, posterior[i])
   end
 end

 function insert_chain!(a3d, chain, posterior)
   for i in 1:size(a3d, 1)
     a3d[i,:,chain] = posterior[i, :]
   end
 end

 function create_mcmcchains(a3d, cnames;start=1)
   Chains(a3d, cnames; start=start)
 end
 
 function create_mcmcchains(a3d, cnames, sections::Dict{Symbol, Vector{String}};
   start=1)
   Chains(a3d, cnames, sections; start=start)
 end
