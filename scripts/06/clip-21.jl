using StatisticalRethinking, UnicodePlots

df = sim_happiness()
precis(df) |> display

UnicodePlots.histogram(df[:, :age], closed=:right, xlabel="age") |> display
UnicodePlots.histogram(df[:, :married], closed=:right, xlabel="married") |> display
UnicodePlots.histogram(df[:, :happiness], closed=:right, xlabel="happiness") |> display
