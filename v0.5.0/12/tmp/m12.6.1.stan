data{
    int total_tools[10];
    real logpop[10];
    int society[10];
}
parameters{
    real a;
    real bp;
    vector[10] a_society;
    real<lower=0> sigma_society;
}
model{
    vector[10] mu;
    sigma_society ~ cauchy( 0 , 1 );
    a_society ~ normal( 0 , sigma_society );
    bp ~ normal( 0 , 1 );
    a ~ normal( 0 , 10 );
    for ( i in 1:10 ) {
        mu[i] = a + a_society[society[i]] + bp * logpop[i];
        mu[i] = exp(mu[i]);
    }
    total_tools ~ poisson( mu );
}