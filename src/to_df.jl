function sort_sections(chn::MCMCChains.AbstractChains)
  smap = keys(chn.name_map)
  section_list = Vector{Symbol}(undef, length(smap))
  indx = 1
  if :parameters in smap
    section_list[1] = :parameters
    indx += 1
  end
  if :internals in smap
    section_list[end] = :internals
  end
  for par in smap
    if !(par in [:parameters, :internals])
      section_list[indx] = par
      indx += 1
    end
  end
  section_list
end

function to_df(chn::MCMCChains.AbstractChains, sections=Nothing)
  df = DataFrame()
  section_list = sections !== Nothing ? sections : sort_sections(chn)
  for section in section_list
    for par in chn.name_map[section]
        x = get(chn, Symbol(par))
        d, c = size(x[Symbol(par)])
        df = hcat(df, DataFrame(Symbol(par) => reshape(convert(Array{Float64}, 
          x[Symbol(par)]), d*c)[:, 1]))
    end
  end
  df
end
