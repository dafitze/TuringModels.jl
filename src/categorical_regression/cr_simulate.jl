@kwdef struct CategoricalRegressionParams <: ModelParams
  α::Real = 0.0
  β::Real = 0.5
  σ²::Real = 50.0
end

function simulate(;model_params::CategoricalRegressionParams, nsubjects::Int64 = 20, categories = ["pre", "post"])

  x = @chain Base.Iterators.product(1:nsubjects, categories) begin
    collect()
    vec()
    unzip()
  end

  @unpack α, β, σ² = model_params

  tmp = @chain DataFrame(vpn = x[1],
                         cond = x[2]) begin
  transform(_, :cond => ByRow(x -> isequal(x, "pre") ? 0 : 1) => :dummy_cond)
  transform(_, :dummy_cond => ByRow(x -> α + β * x) => :linpred)
  transform(_, :linpred => ByRow(x -> rand(Normal(x, σ²))) => :value)
  end
  tmp



  # @assert 0 < β < 100

  #linpred = α .+ β .* x
  #return linpred
end

