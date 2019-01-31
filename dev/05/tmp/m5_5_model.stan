data{
    real kcal_per_g[17];
    real log_mass[17];
}
parameters{
    real a;
    real bm;
    real sigma;
}
model{
    vector[17] mu;
    sigma ~ uniform( 0 , 1 );
    bm ~ normal( 0 , 1 );
    a ~ normal( 0 , 100 );
    for ( i in 1:17 ) {
        mu[i] = a + bm * log_mass[i];
    }
    kcal_per_g ~ normal( mu , sigma );
}