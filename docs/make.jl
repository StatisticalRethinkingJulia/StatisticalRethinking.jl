using StatisticalRethinking
using Literate
using Documenter
using Random
Random.seed!(UInt32[0x57a97f0d, 0x1a38664c, 0x0dddb228, 0x7dbba96f])

# The idea: generate both docs and notebooks using Literate
# Again based on ideas from Tamas Papp!

const src_path = @__DIR__

"Relative path using the StatisticalRethinking src/ directory."
rel_path(parts...) = normpath(joinpath(src_path, parts...))

DOC_ROOT = rel_path("..", "docs")
DocDir =  rel_path("..", "docs", "src")
chapters = ["00", "02", "03", "04", "08", "10", "11", "12"]

for chapter in chapters
  ProjDir = rel_path( "..", "chapters", chapter)
  DocDir =  rel_path("..", "docs", "src", chapter)
  
  !isdir(ProjDir) && break
  
  cd(ProjDir) do
    
    filelist = readdir()
    for file in filelist
      # Check existance of file
      if !isdir(file) && (file[1:4] == "clip" || file[1] == 'm') && file[end-2:end] == ".jl"  
        
        # Process CmdStan files
        if file[end-3:end] == "s.jl"
          println("\nCmdStan file $file\n")
          isfile(joinpath(DocDir, file[1:end-4], "s.md")) && rm(joinpath(DocDir, file[1:end-4], "s.md"))
          Literate.markdown(joinpath(ProjDir, file), DocDir, documenter=true)        
        # Process Mamba files
        elseif file[end-3:end] == "m.jl"
          println("\nMamba file $file\n")
          isfile(joinpath(DocDir, file[1:end-4], "m.md")) && rm(joinpath(DocDir, file[1:end-4], "m.md"))
          Literate.markdown(joinpath(ProjDir, file), DocDir, documenter=true)        
        # Process Turing files
        elseif file[end-3:end] == "t.jl"
          println("\nTuring file $file, skipped\n")
        # Process model files files
        elseif file[1] == 'm' && file[end-2:end] == ".jl"          
          println("\nModel file $file\n")
          isfile(joinpath(DocDir, file[1:end-3], ".md")) && rm(joinpath(DocDir, file[1:end-3], ".md"))
          Literate.markdown(joinpath(ProjDir, file), DocDir, documenter=true)
        # Process all remaining clip  files (neither CmdStan, Turing, Mamba or models)
        else       
          println("\nOther file $file\n")
          isfile(joinpath(DocDir, file[1:end-3], ".md")) && rm(joinpath(DocDir, file[1:end-3], ".md"))
          Literate.markdown(joinpath(ProjDir, file), DocDir, documenter=true)        
        end
              
      end # if !isdir
    end # for
  end # cd
  println()
end # for chapter

makedocs(root = DOC_ROOT,
    modules = Module[],
    sitename = "StatisticalRethinking.jl",
    authors = "Rob Goedman, Richard Torkar, and contributors.",
    pages = [
      "Home" => "index.md",
      "Chapter 0" => [
        "`clip_01_03`" => "00/clip_01_03.md",
        "`clip_04_04`" => "00/clip_04_05.md"
      ],
      "Chapter 2" => [
        "`clip_01_02`" => "02/clip_01_02.md",
        "`clip_03_05`" => "02/clip_03_05.md",
        "`clip_06_07`" => "02/clip_06_07.md",
        "`clip_08t`" => "02/clip_08t.md",
        "`clip_08m`" => "02/clip_08m.md",
        "`clip_08s`" => "02/clip_08s.md"
      ],
      "Chapter 3" => [
        "`clip_01`" => "03/clip_01.md",
        "`clip_02_05`" => "03/clip_02_05.md",
        "`clip_05s`" => "03/clip_05s.md",
        "`clip_06_16s`" => "03/clip_06_16s.md"
      ],
      "Chapter 4" => [
        "`clip_01_06`" => "04/clip_01_06.md",
        "`clip_07.0s`" => "04/clip_07.0s.md",
        "`clip_07.1s`" => "04/clip_07.1s.md",
        "`clip_38.0s`" => "04/clip_38.0s.md",
        "`clip_38.1s`" => "04/clip_38.1s.md",
        "`clip_38.0m`" => "04/clip_38.0m.md",
        "`clip_38.1m`" => "04/clip_38.1m.md",
        "`clip_38.t`" => "04/clip_38t.md"
      ],
      "Chapter 8" => [
        "`m8.1.jl`" => "08/m8.1.md",
        "`m8.1t.jl`" => "08/m8.1t.md",
        "`m8.2.jl`" => "08/m8.2.md",
        "`m8.3.jl`" => "08/m8.3.md",
        "`m8.4.jl`" => "08/m8.4.md"
      ],
      "Chapter 10" => [
        "`m10.3.jl`" => "10/m10.3.md",
        "`m10.4.jl`" => "10/m10.4.md"
      ],
      "Chapter 11" => [
        "`m11.5.jl`" => "11/m11_5.md"
      ],
      "Chapter 12" => [
        "`m12.1.jl`" => "12/m12_1.md",
        "`m12.2.jl`" => "12/m12_2.md",
        "`m12.3.jl`" => "12/m12_3.md"
      ],
    ]
)

deploydocs(root = DOC_ROOT,
    repo = "github.com/StanJulia/StatisticalRethinking.jl.git",
 )
