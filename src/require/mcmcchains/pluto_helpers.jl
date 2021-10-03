
CHNS(chns::MCMCChains.Chains) = Text(sprint(show, "text/plain", chns))

# Pluto helpers for MCMCChains

HPD(chns::MCMCChains.Chains) = Text(sprint(show, "text/plain", hpd(chns)))

export
    HPD,
    CHNS
