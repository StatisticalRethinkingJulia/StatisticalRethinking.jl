function DataFrame(df::DataFrame, sym::Union{Symbol, String})
    n = string.(names(df))
    syms = string(sym)
    sel = String[]
    for (i, s) in enumerate(n)
        if length(s) > length(syms) && syms == n[i][1:length(syms)] &&
            n[i][length(syms)+1] in ['[', '.', '_']
            append!(sel, [n[i]])
        end
    end
    length(sel) == 0 && error("$syms not in $n")
    df[:, sel]
end
