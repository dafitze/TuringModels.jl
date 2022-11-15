abstract type ModelParams end
abstract type TimeSeriesParams end

@kwdef struct ARModelParams <: TimeSeriesParams
  α::Float64 = 0.3
  β₁::Float64 = 0.4
  β₂::Float64 = 0.4
  noise::Sampleable = Normal(0, 0.1)
end

@kwdef struct MVModelParams <: TimeSeriesParams
  α::Float64 = 0.3
  β₁::Float64 = 0.2
  σₑ::Float64 = 0.4
  noise::Sampleable = Normal(0, 0.1)
end

function simulate(params::ARModelParams, 
    stimulus_levels::Vector{Float64};
    nreps::Int = 500, noise::Bool = false)

  x = repeat(stimulus_levels, inner = nreps)

  @unpack α, β₁, β₂ = params

  @assert 0 < α < 1

  internal_noise = noise === true ? rand(params.noise, length(x)) : 0

  for t in 3:N
    μ = α + β₁ * x₁[t-1]# + β₂ * x₁[t - 2]
    x₁[t] = rand(Normal(μ, 0.001),1)[1]
  end

  d = DataFrame(x = x, y = y)
  d
end

function simulate(params::MVModelParams, 
    stimulus_levels::Vector{Float64};
    nreps::Int = 500, noise::Bool = false)

  x = repeat(stimulus_levels, inner = nreps)

  @unpack α, β₁, σₑ = params

  @assert 0 < α < 1

  internal_noise = noise === true ? rand(params.noise, length(x)) : 0

  for i=3:N
    x[i] = α + rand(Normal(0, σₑ)) + β₁ * rand(Normal(0, σₑ))
  end

  d = DataFrame(x = x, y = y)
  d
end
