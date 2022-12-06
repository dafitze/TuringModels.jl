module TuringModels

using Unzip, Random, Distributions, StatsFuns, DataFrames, Chain, Turing
using Base: @kwdef
using Parameters: @unpack

abstract type ModelParams end
abstract type ModelPrior end
export ModelParams, ModelPrior

#include("psychometric_function/pf_models.jl")
#include("psychometric_function/pf_simulate.jl")
#include("categorical_regression/cr_models.jl")
#include("categorical_regression/cr_simulate.jl")
include("rethink/ls.jl")

end # module TuringModels
