@kwdef struct categorical_regression_prior <: ModelPrior
  α::Distribution = Normal(0, 1)
  β::Distribution = Normal(0, 1)
  σ²::Distribution = truncated(Normal(0, 100); lower = 0) # Gelmans: noninformative variance prior
end

@model function categorical_regression(x::Vector{Float64}, y::Vector{Int}, prior::categorical_regression_prior)

  α ~ Normal(0, 3) 
  β ~ Normal(0,1)
  σ² ~ truncated(Normal(0, 100); lower = 0) # Gelmans: noninformative variance prior  

linpred = α .+ β .* x
y .~ Normal(linpred, σ²)
