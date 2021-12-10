# This file contains helper functions to display in Pluto.jl

PRECIS(df::DataFrame) = Text(precis(df; io=String))

export
    PRECIS

CHNS(chns::MCMCChains.Chains) = Text(sprint(show, "text/plain", chns))

# Pluto helpers for MCMCChains

HPD(chns::MCMCChains.Chains) = Text(sprint(show, "text/plain", hpd(chns)))

export
    HPD,
    CHNS

