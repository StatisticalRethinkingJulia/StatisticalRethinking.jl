# This file contains helper functions to display in Pluto.jl

struct QM
    nt::NamedTuple
end

function Base.show(io::IO, ::MIME"test/plain", qm::QM)
    write(io, qm)
end

struct QuapModel
    nt::NamedTuple
end

function Base.show(io::IO, ::MIME"test/plain", qm::QuapModel)
    write(io, qm)
end

PRECIS(df::DataFrame) = Text(precis(df; io=String))

CHNS(chns::KeyedArray) = Text(sprint(show, "text/plain", chns))

export
    QuapModel,
    QM,
    PRECIS,
    CHNS