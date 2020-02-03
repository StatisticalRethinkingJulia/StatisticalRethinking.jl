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

