using StatisticalRethinking, GLM
gr(size=(500, 500));

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);
first(df, 5)

m = lm(@formula(height ~ weight), df)

coef(m)

scatter( df[:height], residuals(m), xlab="Speed",
ylab="Model residual values", lab="Model residuals")

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

