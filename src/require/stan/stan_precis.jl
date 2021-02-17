"""

# precis

$(SIGNATURES)

"""
function precis(sm::SampleModel; io = stdout, digits = 2, depth = Inf, alpha = 0.11)
    df = read_samples(sm; output_format=:dataframe)
    precis(df)
end
