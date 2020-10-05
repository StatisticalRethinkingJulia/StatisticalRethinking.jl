"""

# precis

$(SIGNATURES)

"""
function precis(nt::NamedTuple; io = stdout, digits = 2, depth = Inf, alpha = 0.11)

    # Simulate samples from quap

    df = DataFrame()
    precis(df)
end

"""

# precis

$(SIGNATURES)

"""
function precis(m::DynamicPPL.Model; io = stdout, digits = 2, depth = Inf, alpha = 0.11)
    
    # Sample from the Turing model

    df = DataFrame()
    precis(df)
end
