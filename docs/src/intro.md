# StatisticalRethinking

This package will contain Julia versions of selected code snippets contained in the R package "rethinking" associated with the book [Statistical Rethinking](https://xcelab.net/rm/statistical-rethinking/) by Richard McElreath.

In the book and associated R package `rethinking`, statistical models are defined as illustrated below:

```
m4.3 <- map(
    alist(
        height ~ dnorm( mu , sigma ) ,
        mu <- a + b*weight ,
        a ~ dnorm( 156 , 100 ) ,
        b ~ dnorm( 0 , 10 ) ,
        sigma ~ dunif( 0 , 50 )
    ) ,
    data=d2
)
```

The author of the book states: "*If that (the statistical model) doesn't make much sense, good. ... you're holding the right textbook, since this book teaches you how to read and write these mathematical descriptions*"  (page 77).

This package is intended to allow experimenting with this learning process using 3 available mcmc options in Julia.
