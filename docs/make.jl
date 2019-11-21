using StatisticalRethinking
using Literate
using Documenter

# The idea: generate both docs and notebooks using Literate
# Based on ideas and work from Tamas Papp!

DOC_ROOT = rel_path("..", "docs")
DocDir =  rel_path("..", "docs", "src")

page_list = Array{Pair{String, Any}, 1}();
append!(page_list, [Pair("Home", "intro.md")]);
append!(page_list, [Pair("Layout", "layout.md")])
append!(page_list, [Pair("Versions", "versions.md")]);
append!(page_list, [Pair("Acknowledgements", "acknowledgements.md")]);
append!(page_list, [Pair("References", "references.md")])

for chapter in keys(script_dict)
  ProjDir = rel_path( "..", "scripts", chapter)
  DocDir =  rel_path("..", "docs", "src", chapter)
  
  !isdir(ProjDir) && break
  
  cd(ProjDir) do
    
    script_list = Array{Pair{String, Any}, 1}();
    for script in script_dict[chapter]
      if script.doc
        file = script.scriptfile
        append!(script_list, [Pair(file[1:end-3], "$(chapter)/$(file[1:end-3]).md")])
        if script.exe && isfile(file)
          isfile(joinpath(DocDir, file[1:end-3], ".md")) &&
            rm(joinpath(DocDir, file[1:end-3], ".md"))
          Literate.markdown(joinpath(ProjDir, file), DocDir, documenter=true)        
        end
      end
    end
    
    # Remove tmp directory used by cmdstan 
    append!(page_list, [Pair("Chapter $(chapter)", script_list)])
    isdir("tmp") && rm("tmp", recursive=true);
    println("\nCompleted documentation generation for chapter $chapter\n")
    
  end # cd
end # for chapter

append!(page_list, [Pair("Functions", "index.md")])

makedocs(
    format = Documenter.HTML(prettyurls = haskey(ENV, "GITHUB_ACTIONS")),
    sitename = "StatisticalRethinking.jl",
    authors = "Rob Goedman and contributors.",
    doctest = false,
    strict = false,
    pages = page_list
)

deploydocs(root = DOC_ROOT,
    repo = "github.com/StatisticalRethinkingJulia/StatisticalRethinking.jl.git",
    push_preview=true,
 )
