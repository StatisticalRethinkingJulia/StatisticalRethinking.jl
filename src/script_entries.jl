# Default for each script is to generate a notebook (nb = true), execute/test that generated notebook (exe = true) and include the results in the documentation (doc = true). If exe = false and doc = true it is assumed the appropriate .md files are created and stored in docs/src/chapter/... (this is useful for very long runs that will terminate Travis).

struct Script_entry
  script::AbstractString
  nb::Bool
  exe::Bool
  doc::Bool
end

script_entry(script; nb=true, exe=true, doc=true) = Script_entry(script, nb, exe, doc)

script_dict = DataStructures.OrderedDict{AbstractString, Vector{Script_entry}}(
  "00" => [
    script_entry("clip-01-03.jl"),
    script_entry("clip-04-05.jl")
  ],
  "02" => [
    script_entry("clip-01-02.jl"),
    script_entry("clip-03-05.jl"),
    script_entry("clip-06-07.jl"),
    script_entry("clip-08m.jl"), 
    script_entry("clip-08s.jl"),
    script_entry("clip-08t.jl")
  ],
  "03" => [
    script_entry("clip-01.jl"),
    script_entry("clip-02-05.jl"),
    script_entry("clip-05s.jl"),
    script_entry("clip-06-16s.jl")
  ],
  "04" => [
    script_entry("clip-01-06.jl"),
    script_entry("clip-07.0s.jl"),
    script_entry("clip-07.1s.jl", doc = false),
    script_entry("clip-38.0m.jl"), 
    script_entry("clip-38.1m.jl", exe = false, doc = false), 
    script_entry("clip-38.0s.jl"),
    script_entry("clip-38.1s.jl", exe = false, doc = false),
    script_entry("clip-38.2s.jl", nb = false, exe = false, doc = false),
    script_entry("clip-38.3s.jl", nb = false, exe = false, doc = false),
    script_entry("clip-38.4s.jl", nb = false, exe = false, doc = false),
    script_entry("clip-38.5s.jl", nb = false, exe = false, doc = false),
    script_entry("clip-38.6s.jl", nb = false, exe = false, doc = false),
    script_entry("clip-38.7s.jl"),
    script_entry("clip-43s.jl"),
    script_entry("clip-43t.jl"),
    script_entry("clip-45-47s.jl"),
    script_entry("clip-48-54s.jl")
  ],
  "05" => [
    script_entry("clip-01s.jl")
  ],
  "08" => [
    script_entry("m8.1t.jl"),
    script_entry("m8.1.jl", exe = false, doc = false),
    script_entry("m8.2.jl", exe = false, doc = false),
    script_entry("m8.3.jl", exe = false, doc = false),
    script_entry("m8.4.jl", exe = false, doc = false)
  ],
  "10" => [
    script_entry("m-good_stan.jl", exe = false, doc = false),
    script_entry("m-pois.jl", exe = false, doc = false),
    script_entry("m10.10stan.c.jl", exe = false, doc = false),
    script_entry("m10.10stan.jl", exe = false, doc = false),
    script_entry("m10.3.jl", exe = false, doc = false),
    script_entry("m10.4.jl", exe = false, doc = false)
  ],
  "11" => [
    script_entry("m11.5.jl", exe = false, doc = false)
  ],
  "12" => [
    script_entry("m12.1.jl", exe = false, doc = false),
    script_entry("m12.2.jl", exe = false, doc = false),
    script_entry("m12.3.jl", exe = false, doc = false),
    script_entry("m12.4.jl", exe = false, doc = false),
    script_entry("m12.5.jl", exe = false, doc = false),
    script_entry("m12.6.jl", exe = false, doc = false)
  ]
);
