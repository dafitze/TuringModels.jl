@kwdef struct logistic_regression_prior <: ModelPrior
  α::Distribution = Normal(0,1)
  β::Distribution = truncated(Normal(0, 1), lower=0, upper=Inf)
end

@model function logistic_regression(x::Vector{Float64}, y::Vector{Int}, prior::logistic_regression_prior)
  α ~ prior.α
  β ~ prior.β
  linpred = α .+ β .* x

  y .~ Bernoulli.(logistic.(linpred))
end

@kwdef struct mixture_model_prior <: ModelPrior
  α::Distribution = Normal(0, 1)
  β::Distribution = truncated(Normal(0, 1), lower=0, upper=Inf)
  θ::Distribution = Beta(1, 10)
  γ::Distribution = Beta(1, 10)
end

@model function mixture_model(x::Vector{Float64}, y::Vector{Int}; f::Function = logistic, prior::mixture_model_prior) # add paramer for link function
  α ~ prior.α
  β ~ prior.β
  linpred = α .+ β .* x
  θ ~ prior.θ
  γ ~ prior.γ

  y .~ Bernoulli.(θ * γ .+ (1-θ) .* f.(linpred))
end

@model function mixture_model_2(x::Vector{Float64}, y::Vector{Int}; f::Function = logistic, prior::mixture_model_prior)
  α ~ prior.α
  β ~ prior.β
  linpred = α .+ β .* x
  θ ~ prior.θ
  γ ~ prior.γ

  y .~ Bernoulli.(θ .* f(γ).+ (1-θ) .* f.(linpred))
end


@model function mixture_model_discrete(x::Vector{Float64}, y::Vector{Int}; f::Function = logistic, prior::mixture_model_prior)
  α ~ prior.α
  β ~ prior.β
  linpred = α .+ β .* x
  θ ~ prior.θ
  γ ~ prior.γ

  y .~ Bernoulli.(θ .* f(γ).+ (1-θ) .* f.(linpred))
end

@kwdef struct psychophysics_model_prior <: ModelPrior
  α::Distribution = Normal(0, 1)
  β::Distribution = truncated(Normal(0, 1), lower=0, upper=Inf)
  λ::Distribution = Beta(1, 10)
  γ::Distribution = Beta(1, 10)
end

@model function psychophysics_model(x::Vector{Float64}, y::Vector{Int}; f::Function = logistic, prior::psychophysics_model_prior)
  α ~ prior.α
  β ~ prior.β
  linpred = α .+ β .* x
  λ ~ prior.λ
  γ ~ prior.γ

  y .~ Bernoulli.(γ .+ (1-γ-λ) .* f.(linpred))
end




