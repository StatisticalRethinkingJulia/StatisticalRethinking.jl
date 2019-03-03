data{
    int N;
    real height[N];
    real weight_s2[N];
    real weight_s[N];
}
parameters{
    real a;
    real b1;
    real b2;
    real sigma;
}
model{
    vector[N] mu;
    sigma ~ uniform( 0 , 50 );
    b2 ~ normal( 0 , 10 );
    b1 ~ normal( 0 , 10 );
    a ~ normal( 178 , 100 );
    for ( i in 1:N ) {
        mu[i] = a + b1 * weight_s[i] + b2 * weight_s2[i];
    }
    height ~ normal( mu , sigma );
}