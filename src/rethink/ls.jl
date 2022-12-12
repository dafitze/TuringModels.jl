@kwdef struct MODEL
  param_sim::Union{ModelParams, Nothing} = nothing
  data_sim::Union{DataFrame, Nothing} = nothing
end


@kwdef struct LinearRegressionParams <: ModelParams
  α::Float64 = 0.0
  β::Float64 = 0.5
  σ::Float64 = 0.1
end


function simulate_data(;parameters::LinearRegressionParams, x::Vector{Float64})
  tmp = @chain DataFrame(x = x) begin 
    transform(:x => ByRow(x -> parameters.α .+ parameters.β * x) => :linpred)
    transform(:linpred => ByRow(x -> rand(Normal(x, parameters.σ),1)[1]) => :y)
  end
  return tmp
end

function plot_simulation(data)
  layers_linpred = visual(Scatter, markersize = 10, color = :grey)
  layers_y = visual(Scatter, markersize = 20, marker = :star4,  color = :black)
  map_linpred = mapping(:x, :linpred)
  map_y = mapping(:x, :y)
  p = draw(data(d) * map_linpred * layers_linpred +
           data(d) * map_y * layers_y)
  DataUtils.disp(p)
end
