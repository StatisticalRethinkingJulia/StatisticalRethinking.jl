> stancode(m13.1)
data{
    int<lower=1> N;
    int<lower=1> N_cafe;
    real wait[N];
    int cafe[N];
    int afternoon[N];
}
parameters{
    vector[N_cafe] b_cafe;
    vector[N_cafe] a_cafe;
    real a;
    real b;
    vector<lower=0>[2] sigma_cafe;
    real<lower=0> sigma;
    corr_matrix[2] Rho;
}
transformed parameters{
    vector[2] v_a_cafeb_cafe[N_cafe];
    vector[2] Mu_ab;
    cov_matrix[2] SRS_sigma_cafeRho;
    for ( j in 1:N_cafe ) {
        v_a_cafeb_cafe[j,1] = a_cafe[j];
        v_a_cafeb_cafe[j,2] = b_cafe[j];
    }
    for ( j in 1:2 ) {
        Mu_ab[1] = a;
        Mu_ab[2] = b;
    }
    SRS_sigma_cafeRho = quad_form_diag(Rho,sigma_cafe);
}
model{
    vector[N] mu;
    Rho ~ lkj_corr( 2 );
    sigma ~ cauchy( 0 , 2 );
    sigma_cafe ~ cauchy( 0 , 2 );
    b ~ normal( 0 , 10 );
    a ~ normal( 0 , 10 );
    v_a_cafeb_cafe ~ multi_normal( Mu_ab , SRS_sigma_cafeRho );
    for ( i in 1:N ) {
        mu[i] = a_cafe[cafe[i]] + b_cafe[cafe[i]] * afternoon[i];
    }
    wait ~ normal( mu , sigma );
}
generated quantities{
    vector[N] mu;
    real dev;
    dev = 0;
    for ( i in 1:N ) {
        mu[i] = a_cafe[cafe[i]] + b_cafe[cafe[i]] * afternoon[i];
    }
    dev = dev + (-2)*normal_lpdf( wait | mu , sigma );
}
