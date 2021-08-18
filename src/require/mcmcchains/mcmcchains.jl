using .MCMCChains
using .AxisArrays

if !isdefined(Main, :Turing)

    # This is copied and shortened from Turing2MonteCarloChains.jl!

    function MonteCarloMeasurements.Particles(t::NTuple{N, <:AxisArrays.AxisArray}; start=0) where N
        [adapted_particles(t[i].data[start+1:end,:]) for i in 1:N]
    end

    function MonteCarloMeasurements.Particles(a::AxisArrays.AxisArray; start=0)
        adapted_particles(a.data[start+1:end,:])
    end

    """
        Particles(chain::Chains; start=0)

    Return a named tuple of particles or vector of particles where the keys
    are the symbols in the Turing model that produced the chain. `start>0` can
    be given to discard a number of samples from the beginning of the chain.

    ```
    """
    function MonteCarloMeasurements.Particles(chain::Chains; start=0)
        p = get_params(chain)
        (;collect((k => Particles(getfield(p,k); start=start) for k in keys(p)))...)
    end

    function adapted_particles(v)
        T = float(typeof(v[1]))
        Particles(vec(T.(v)))
    end

end
