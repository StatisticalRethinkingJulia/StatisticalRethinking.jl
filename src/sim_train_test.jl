function sim_train_test(;
    N = 20,
    K = 3,
    rho = [0.15, -0.4]) 

    n_dim = 1 + length(rho)
    n_dim = n_dim < K ? K : n_dim
    
    Rho = Matrix{Float64}(I, n_dim, n_dim)
    for i in 1:length(rho)
        Rho[i+1, 1] = Rho[1, i + 1] = rho[i]
    end
    
    x_train = Matrix(rand(MvNormal(zeros(n_dim), Rho), N)')
    x_test = Matrix(rand(MvNormal(zeros(n_dim), Rho), N)')
    y = x_train[:, 1]
    x_train = x_train[:, 2:n_dim]
    (y, x_train, x_test[:, 2:n_dim])
end

export
    sim_train_test