data {
    int N;
    int N_societies;
    int total_tools[N];
    real logpop[N];
    int society[N];
}
parameters{
    real a;
    real bp;
    vector[N_societies] a_society;
    real<lower=0> sigma_society;
}
model{
    vector[N_societies] mu;
    sigma_society ~ cauchy( 0 , 1 );
    a_society ~ normal( 0 , sigma_society );
    bp ~ normal( 0 , 1 );
    a ~ normal( 0 , 10 );
    for ( i in 1:N ) {
        mu[i] = a + a_society[society[i]] + bp * logpop[i];
        mu[i] = exp(mu[i]);
    }
    total_tools ~ poisson( mu );
}