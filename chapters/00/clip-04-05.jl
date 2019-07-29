using StatisticalRethinking, GLM
#gr(size=(600, 600));

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);
df2 = filter(row -> row[:age] >= 18, df);
first(df2, 5)

m = lm(@formula(height ~ weight), df2)

coef(m)

scatter( df2[!, :height], residuals(m), xlab="Height",
ylab="Model residual values", lab="Model residuals")

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

