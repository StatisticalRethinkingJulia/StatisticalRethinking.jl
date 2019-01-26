
# Model written by Scott Spencer

# For now used to see if this is possible with DynamicHMC

m14.1_ model = "
  data {
    int N;
    vector[N] A;
    vector[N] R;
    vector[N] Dobs;
    vector[N] Dsd;
  }
  parameters {
    real a;
    real ba;
    real br;
    real<lower=0> sigma;
    vector[N] Dest;
  }
  model {
    vector[N] mu; 
    // priors
    target += normal_lpdf(a | 0, 10);
    target += normal_lpdf(ba | 0, 10);
    target += normal_lpdf(br | 0, 10);
    target += cauchy_lpdf(sigma | 0, 2.5);
  
    // linear model
    mu = a + ba * A + br * R;
  
    // likelihood
    target += normal_lpdf(Dest | mu, sigma);
  
    // prior for estimates
    target += normal_lpdf(Dobs | Dest, Dsd);
  }
  generated quantities {
    vector[N] log_lik;
    {
      vector[N] mu;
      mu = a + ba * A + br * R;
      for(i in 1:N) log_lik[i] = normal_lpdf(Dest[i] | mu[i], sigma);
    }
  }
";

#Organize data and sample from model.

R_code = "

dat <- list(
  N = NROW(d),
  A = d$MedianAgeMarriage,
  R = d$Marriage,
  Dobs = d$Divorce,
  Dsd = d$Divorce.SE
)

## R code 14.2
library(rethinking)
data(WaffleDivorce)
d <- WaffleDivorce

# points
plot( d$Divorce ~ d$MedianAgeMarriage , ylim=c(4,15) ,
    xlab="Median age marriage" , ylab="Divorce rate" )

# standard errors
for ( i in 1:nrow(d) ) {
    ci <- d$Divorce[i] + c(-1,1)*d$Divorce.SE[i]
    x <- d$MedianAgeMarriage[i]
    lines( c(x,x) , ci )
}

## R code 14.3
dlist <- list(
    div_obs=d$Divorce,
    div_sd=d$Divorce.SE,
    R=d$Marriage,
    A=d$MedianAgeMarriage
)

m14.1 <- map2stan(
    alist(
        div_est ~ dnorm(mu,sigma),
        mu <- a + bA*A + bR*R,
        div_obs ~ dnorm(div_est,div_sd),
        a ~ dnorm(0,10),
        bA ~ dnorm(0,10),
        bR ~ dnorm(0,10),
        sigma ~ dcauchy(0,2.5)
    ) ,
    data=dlist ,
    start=list(div_est=dlist$div_obs) ,
    WAIC=FALSE , iter=5000 , warmup=1000 , chains=2 , cores=2 ,
    control=list(adapt_delta=0.95) )

## R code 14.4
precis( m14.1 , depth=2 )
"