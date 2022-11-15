@kwdef struct CategoricalRegressionParams <: ModelParams
  α::Real = 0.0
  β::Real = 0.5
  σ²::Real = 50.0
end

function simulate(;model_params::CategoricalRegressionParams, nsubjects::Int64 = 20)
  
  @unpack α, β, σ² = model_params

  # @assert 0 < β < 100

  linpred = α .+ β .* x
  return linpred
end

