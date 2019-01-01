# Default for each script is to generate a notebook (nb = true), execute/test that generated notebook (exe = true) and include the results in the documentation (doc = true). 

struct Script_entry
  script::AbstractString
  nb::Bool
  exe::Bool
  doc::Bool
end

script_entry(script; nb=true, exe=true, doc=true) = Script_entry(script, nb, exe, doc)

script_dict = DataStructures.OrderedDict{AbstractString, Vector{Script_entry}}(
  "00" => [
    script_entry("clip_01_03.jl"),
    script_entry("clip_04_05.jl")
  ],
  "02" => [
    script_entry("clip_01_02.jl"),
    script_entry("clip_03_05.jl"),
    script_entry("clip_06_07.jl"),
    script_entry("clip_08m.jl"), 
    script_entry("clip_08s.jl"),
    script_entry("clip_08t.jl", exe = false, doc = true)
    ],
  "03" => [
    script_entry("clip_01.jl"),
    script_entry("clip_02_05.jl"),
    script_entry("clip_05s.jl"),
    script_entry("clip_06_16s.jl")
  ],
  "04" => [
    script_entry("clip_01_06.jl"),
    script_entry("clip_07.0s.jl"),
    script_entry("clip_07.1s.jl", doc = false),
    script_entry("clip_38.0m.jl"), 
    script_entry("clip_38.1m.jl", exe = false, doc = false), 
    script_entry("clip_38.0s.jl"),
    script_entry("clip_38.1s.jl", exe = false, doc = false),
    script_entry("clip_38.2s.jl", nb = false, exe = false, doc = false),
    script_entry("clip_38.3s.jl", nb = false, exe = false, doc = false),
    script_entry("clip_38.4s.jl", nb = false, exe = false, doc = false),
    script_entry("clip_38.5s.jl", nb = false, exe = false, doc = false),
    script_entry("clip_38.6s.jl", nb = false, exe = false, doc = false),
    script_entry("clip_38.7s.jl"),
    script_entry("clip_43s.jl"),
    script_entry("clip_43t.jl", exe = false, doc = true),
    script_entry("clip_45_47s.jl"),
    script_entry("clip_48_54s.jl")
  ],
  "05" => [
    script_entry("clip_01s.jl")
  ],
  "08" => [
    script_entry("m8.1t.jl", exe = false, doc = true),
    script_entry("m8.1.jl", exe = false, doc = false),
    script_entry("m8.2.jl", exe = false, doc = false),
    script_entry("m8.3.jl", exe = false, doc = false),
    script_entry("m8.4.jl", exe = false, doc = false)
  ],
  "10" => [
    script_entry("m_good_stan.jl", exe = false, doc = false),
    script_entry("m_pois.jl", exe = false, doc = false),
    script_entry("m10.10stan.c.jl", exe = false, doc = false),
    script_entry("m10.10stan.jl", exe = false, doc = false),
    script_entry("m10.3.jl", exe = false, doc = false),
    script_entry("m10.4.jl", exe = false, doc = false)
  ],
  "11" => [
    script_entry("m11.5.jl", exe = false, doc = false)
  ],
  "12" => [
    script_entry("m12_1.jl", exe = false, doc = false),
    script_entry("m12_2.jl", exe = false, doc = false),
    script_entry("m12_3.jl", exe = false, doc = false),
    script_entry("m12_4.jl", exe = false, doc = false),
    script_entry("m12_5.jl", exe = false, doc = false),
    script_entry("m12_6.jl", exe = false, doc = false)
  ]
);
