# This file contains helper functions to display in Pluto.jl

PRECIS(df::DataFrame) = Text(precis(df; io=String))

export
    PRECIS
