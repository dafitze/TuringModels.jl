function bernoulli_mixture(λ, γ, linpred::Vector{Float64})
  λ * γ .+ (1-λ) .* logistic.(linpred)
end

function wichmann_hill(λ, γ, linpred::Vector{Float64})
  γ .+ (1-γ-λ) .* logistic.(linpred)
end

@kwdef struct MixtureModelParams <: ModelParams
  b₀::Real = 0.0
  bₓ::Real = 0.5
  λ::Real = 0.1
  γ::Real = 0.5
  noise::Sampleable = Normal(0, 0.1)
  f::Function = bernoulli_mixture
end

@kwdef struct PsychophysicsModelParams <: ModelParams
  b₀::Real = 0.0
  bₓ::Real = 0.5
  λ::Real = 0.1
  γ::Real = 0.1
  noise::Sampleable = Normal(0, 0.1)
  f::Function = wichmann_hill
end

function simulate(;model_params::ModelParams,
    stimulus_levels::Vector{Float64},
    nreps::Int64=10, noise::Bool=false)

  x = repeat(stimulus_levels, inner = nreps)

  @unpack b₀, bₓ, λ, γ, f = model_params

  @assert 0 < λ < 1
  @assert 0 < γ < 1

  internal_noise = noise === true ? rand(model_params.noise, length(x)) : 0

  linpred = b₀ .+ bₓ .* x .+ internal_noise
  p = f(λ, γ, linpred)

  y = map(x -> rand(Binomial(1, x)), p)
  d = DataFrame(x = x, linpred = linpred, y = y)
  d
end

#simulate(;model_params::ModelParams,
#         stimulus_levels::StepRangeLen{Float64, Base.TwicePrecision{Float64}, Base.TwicePrecision{Float64}, Int64},
#         nreps::Int64=10,
#         noise::Bool=false) = simulate(params, collect(stimulus_levels);
#                                       nreps=nreps, noise=noise)
#
