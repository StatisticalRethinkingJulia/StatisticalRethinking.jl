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

"""

# Array

Array constructor from an MCMCChains.Chains object. Returns 3 dimensionsal
array or and Array of 2 dimensional Arrays. If only a single parameter if selected for
inclusion, a dimension is dropped in both cases, as is e.g. required by cde(), etc.

### Method
```julia
  Array(
    chn::MCMCChains.AbstractChains, 
    sections::Vector{Symbo);
    append_chains::Bool,
    remove_missing_union::Bool
  )
```

### Required arguments
```julia
* `chn` : Chains object to convert to an Array
* `sections = Symbol[]` : Sections form the Chains object to be included
```

### Optional arguments
```julia
* `append_chains=true`  : Append chains into a single column
* ` remove_missing_union=true`  : Convert Union{Missing, Real} to Float64
```

### Examples
```julia
* `Array(chns)` : Array with chain values are appended
* `Array(chns[:par])` : Array with selected parameter chain values are appended
* `Array(chns, [:parameters])`  : Array with only :parameter section
* `Array(chns, [:parameters, :internals])`  : Array also includes :internals section
* `Array(chns, append_chains=false)`  : Array of Arrays, each chain in its own array
* `Array(chns, remove_missing_union=false)` : No conversion to remove missing values
```

"""
function Array(chn::MCMCChains.AbstractChains, 
     sections::Vector{Symbol}=Symbol[];
     append_chains=true, remove_missing_union=true)
     
  section_list = length(sections) == 0 ? sort_sections(chn) : sections
  d, p, c = size(chn.value.data)

  local b
  if append_chains
    first_parameter = true
    for section in section_list
      for par in chn.name_map[section]
        x = get(chn, Symbol(par))
        d, c = size(x[Symbol(par)])
        if first_parameter
          if remove_missing_union
            b = reshape(convert(Array{Float64}, x[Symbol(par)]), d*c)[:, 1]
          else
            b = reshape(x[Symbol(par)], d*c)[:, 1]
          end
          p == 1 && (b = reshape(b, size(b, 1)))
          first_parameter = false
        else
          if remove_missing_union
            b = hcat(b, reshape(convert(Array{Float64}, x[Symbol(par)]), d*c)[:, 1])
          else
            b = hcat(b, reshape(x[Symbol(par)], d*c)[:, 1])
          end
        end
      end
    end
  else
    b=Vector(undef, c)
    for i in 1:c
      first_parameter = true
      for section in section_list
        for par in chn.name_map[section]
          x = get(chn, Symbol(par))
          d, c = size(x[Symbol(par)])
          if first_parameter
            if remove_missing_union
              b[i] = convert(Array{Real}, x[Symbol(par)][:, i])
            else
              b[i] = x[Symbol(par)][:, i]
            end
            p == 1 && (b[i] = reshape(b[i], size(b[i], 1)))
            first_parameter = false
          else
            if remove_missing_union
              b[i] = hcat(b[i], convert(Array{Real}, x[Symbol(par)][:, i]))
            else
              b[i] = hcat(b[i], x[Symbol(par)][:, i])
            end
          end
        end
      end
    end
  end
  b
end  


"""

# DataFrame

DataFrame constructor from an MCMCChains.Chains object. 
Returns either a DataFrame or an Array{DataFrame}

### Method
```julia
  DataFrame(
    chn::MCMCChains.AbstractChains, 
    sections::Vector{Symbo);
    append_chains::Bool,
    remove_missing_union::Bool
  )
```

### Required arguments
```julia
* `chn` : Chains object to convert to an DataFrame
* `sections = Symbol[]` : Sections form the Chains object to be included
```

### Optional arguments
```julia
* `append_chains=true`  : Append chains into a single column
* ` remove_missing_union=true`  : Remove Union{Missing, Real} and AxisArray stuff
```

### Examples
```julia
* `DataFrame(chns)` : DataFrame with chain values are appended
* `DataFrame(chns[:par])` : DataFrame with single parameter (chain values are appended)
* `DataFrame(chns, [:parameters])`  : DataFrame with only :parameter section
* `DataFrame(chns, [:parameters, :internals])`  : DataFrame also includes :internals section
* `DataFrame(chns, append_chains=false)`  : Array of DataFrame, each chain in its own array
* `DataFrame(chns, remove_missing_union=false)` : No conversion to remove missing values
```

"""
function DataFrame(chn::MCMCChains.AbstractChains,
    sections::Vector{Symbol}=Symbol[];
    append_chains=true, remove_missing_union=true)
    
  section_list = length(sections) == 0 ? sort_sections(chn) : sections
  d, p, c = size(chn.value.data)

  local b
  if append_chains
    b = DataFrame()
    for section in section_list
      for par in chn.name_map[section]
          x = get(chn, Symbol(par))
          d, c = size(x[Symbol(par)])
          if remove_missing_union
            b = hcat(b, DataFrame(Symbol(par) => reshape(convert(Array{Float64}, 
              x[Symbol(par)]), d*c)[:, 1]))
          else
            b = hcat(b, DataFrame(Symbol(par) => reshape(x[Symbol(par)], d*c)[:, 1]))
          end
      end
    end
  else
    b = Vector{DataFrame}(undef, c)
    for i in 1:c
      b[i] = DataFrame()
      for section in section_list
        for par in chn.name_map[section]
            x = get(chn, Symbol(par))
            d, c = size(x[Symbol(par)])
            if remove_missing_union
              b[i] = hcat(b[i], DataFrame(Symbol(par) => convert(Array{Float64}, 
                x[Symbol(par)])[:, 1]))
            else
              b[i] = hcat(b[i], DataFrame(Symbol(par) => x[Symbol(par)][:,1]))
            end
        end
      end
    end
  end
  b
end
