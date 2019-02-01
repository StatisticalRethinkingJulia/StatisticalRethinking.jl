data{
    int N;
    int pulled_left[N];
}
parameters{
    real a;
}
model{
    real p;
    a ~ normal( 0 , 10 );
    pulled_left ~ binomial( 1 , inv_logit(a) );
}