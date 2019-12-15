# Introduction to a Stan Language program

using StatisticalRethinking, StanSample

ProjDir = @__DIR__

#=

The `rethinking` model is defined as:

flist <- alist(
  theta ~ Uniform(0, 1)
  k ~ Binomial(N, theta)
)

this model expressed as a Stan language model:

=#

m1_1s = "
// Inferring a rate
data {
  int N;
  int<lower=0> k[N];
  int<lower=1> n[N];
}
parameters {
  real<lower=0,upper=1> theta;
}
model {
  // Prior distribution for θ
  theta ~ uniform(0, 1);

  // Observed Counts
  k ~ binomial(n, theta);
}
";

#=

For this model 3 blocks are used: data, parameters and model.

The first 2 blocks define the data and the parameters for the
model and at the same time can be used to define constraints.

This model represents tossing the globe N times and recording
the results "k" (the number of "W"s observed in N trials).

We know that k can't be negative. We also assume at least 1
trial is performed, hence n >= 1 (in below example we use 15
repetitions of 9 tosses, thus n = 9 in all 15 trials).

N, the vectors k and n are all integers.

Theta, the fraction of water ~ the probability a toss reports "W",
cannot be observed but is the parameter of interest. We know this
probability is between 0 an 1. Thus theta in the parameters block
is constrained.

Theta is a real number.

The third block is the actual model and is pretty much identical
to R's alist.

Note that unfortunately the names of distributions such as Normal
and Binomial are not identical between Stan, R and Julia. The
Stan language uses the Stan convention (starts with lower case).
Also, each Stan language statement ends with a ";".

=#

# Running a Stan language program in Julia

# Once the Stan language model is defined, in this case stored
# in the Julia variable m1_1s, below steps execute the program:

# 1. Create a Stanmodel object:

sm = SampleModel("m1.1s", m1_1s);

# 2. Simulate the results of 15 repetitions of 9 tosses.

N = 15                        # Number of experiments
d = Binomial(9, 0.66)         # 9 tosses (simulate 2/3 is water)
k = rand(d, N)                # Simulate 15 trial results
n = repeat([9], N)            # Each experiment has 9 tosses

# 3. Input data in the form of a Dict

m1_1_data = Dict("N" => N, "n" => n, "k" => k);

# 4. Sample using stan_sample.
 
(sample_file, log_file) = stan_sample(sm, data=m1_1_data);

# 5. Describe and check the results

if !(sample_file == nothing)
  chn = read_samples(sm)

  println()
  show(chn)

  savefig(plot(chn), "$ProjDir/Fig-part_1.png")

end

# End of `intro/intro_part_1.jl`
