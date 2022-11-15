# Auto Regression Time Series Model (1)
@model AR1(x, N) = begin
  α ~ Normal(0,1)
  β₁ ~ Uniform(-1, 1)

  for t in 3:N
    μ = α + β₁ * x[t-1]
    x[t] ~ Normal(μ, 0.1)
  end
end;

# Auto Regression Time Series Model (2)
@model AR2(x, N) = begin
  α ~ Normal(0,1)
  β₁ ~ Uniform(-1, 1)
  β₂ ~ Uniform(-1, 1)

  for t in 3:N
    μ = α + β₁ * x[t-1] + β₂ * x[t - 2]
    x[t] ~ Normal(μ, 0.1)
  end
end;

# Moving Average Model 
@model MA(x, N) = begin
  β₁ ~ Uniform(-1, 1)
  β₂ ~ Uniform(-1, 1)
  μ ~ Uniform(0, 10)
  Δ₁ ~ Normal(0, 1)
  Δ₂ ~ Normal(0, 1)

  for t in 3:N
    val = μ + β₁ * Δ₁ + β₂ * Δ₂
    x[t] ~ Normal(val, 1)
  end
end;

# ARCH Model


# GARCH Model
