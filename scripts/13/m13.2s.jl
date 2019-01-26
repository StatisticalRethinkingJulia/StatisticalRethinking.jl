
# Model written by Scott Spencer

# For now used to see if this is possible with DynamicHMC

m13.2_model = "
data('UCBadmit', package = 'rethinking')
d <- UCBadmit; rm(UCBadmit)
d <- d %>% mutate(male = applicant.gender == 'male',
                  dept_id = as.integer(dept))
```

### 13.2.1. Varying intercepts

Code model in Stan.

```{stan output.var="m13_2"}
data {
  int N;
  int n[N];
  int m[N];
  int A[N];
  int N_depts;
  int dept[N];
}
parameters {
  real alpha;
  real beta;
  real<lower=0> sigma;
  vector[N_depts] a_dept;
}
model {
  vector[N] p;
  target += normal_lpdf(a_dept | alpha, sigma);
  target += normal_lpdf(alpha | 0, 10);
  target += normal_lpdf(beta | 0, 1);
  target += cauchy_lpdf(sigma | 0, 2);
  for(i in 1:N) p[i] = a_dept[dept[i]] + beta * m[i];
  target += binomial_logit_lpmf(A | n, p);
}
generated quantities {
  vector[N] log_lik;
  {
    vector[N] p;
    for (i in 1:N) {
      p[i] = a_dept[dept[i]] + beta * m[i];
      log_lik[i] = binomial_logit_lpmf(A[i] | n[i], p[i]);
    }
  }
}
";
