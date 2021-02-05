function logprob(post_df::DataFrame, x::Matrix, y::Vector, k=k)
    b = Matrix(hcat(post_df[:, [Symbol("b.$i") for i in 1:k]]))
    mu = post_df.a .+ b * x[:, 1:k]'
    logpdf.(Normal.(mu , post_df.sigma),  y')
end

export
    logprob
