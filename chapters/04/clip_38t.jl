using StatisticalRethinking
gr(size=(300,300))

Turing.setadbackend(:reverse_diff)

ProjDir = rel_path("..", "chapters", "04")
cd(ProjDir)

# ### snippet 4.38

howell1 = CSV.read(joinpath(dirname(Base.pathof(StatisticalRethinking)), "..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

# Use only adults

df2 = filter(row -> row[:age] >= 18, df);
y = df2[:height];
x = df2[:weight];

# Define the regression model

@model line(y, x) = begin
    #priors
    alpha ~ Normal(178.0, 100.0)
    beta ~ Normal(0.0, 10.0)
    s ~ Uniform(0, 50)

    #model
    mu = alpha .+ beta*x
    for i in 1:length(y)
      y[i] ~ Normal(mu[i], s)
    end
end;

# Draw the samples

chn = sample(line(y, x), Turing.NUTS(1000, 0.65));

# Describe the chain result

println() # src
describe(chn)
println() # src

# Plot the regerssion line and observations

xi = 30.0:0.1:70.0
yi = mean(chn[:alpha]) .+ mean(chn[:beta])*xi

scatter(x, y, lab="Observations")
plot!(xi, yi, lab="Regression line")

#