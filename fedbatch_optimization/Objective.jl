
const BIG_NUMBER = 5;
const SMALL_NUMBER = 1e-4;
const MAX_DELTA = 0.5;

function Objective(flow_rate_array,TSTART,TSTOP,Ts,data_dictionary)

  # Set the flow function -
  flow_function = DyanmicInterpFlow;

  # Add the flow rate aray to the data dictionary -
  flow_rate_time = collect(0:0.5:TSTOP);

  # Do we have anynegative flow rates?
  idx = find(x->(x<0),flow_rate_array);
  flow_rate_array[idx] = 0.0;

  # Do we have an a BIG flow rate?
  idx = find(x->(x>BIG_NUMBER),flow_rate_array);
  flow_rate_array[idx] = BIG_NUMBER;

  array = [flow_rate_time flow_rate_array];
  data_dictionary["FLOW_RATE_ARRAY"] = array;

  # Solve the model -
  (T,X) = SolveBalances(TSTART,TSTOP,Ts,data_dictionary,flow_function);

  # Calculate the objective (productivity) -
  number_of_time_steps = length(T);
  DARR = [];
  for time_step_index in collect(1:number_of_time_steps)

    time_value = T[time_step_index];
    x_array = X[time_step_index,:];
    volumetric_flow_rate = flow_function(time_value,x_array,data_dictionary);
    push!(DARR,volumetric_flow_rate[5]);
  end

  # Calculuate the product productivity -
  product_productivity::Array{Float64,1} = [];
  product_productivity = DARR.*X[:,2];

  # Calculate the integral of the productvity -
  (AUC) = trapz(vec(T),vec(product_productivity));

  # We want to maximize - so return the negative of AUC
  return -1.0*AUC;
end

function trapz{Tx<:Number, Ty<:Number}(x::Vector{Tx}, y::Vector{Ty})
    # Trapezoidal integration rule
    local n = length(x)
    if (length(y) != n)
        error("Vectors 'x', 'y' must be of same length")
    end
    r = zero(zero(Tx) + zero(Ty))
    if n == 1; return r; end
    for i in 2:n
        r += (x[i] - x[i-1]) * (y[i] + y[i-1])
    end
    #= correction -h^2/12 * (f'(b) - f'(a))
    ha = x[2] - x[1]
    he = x[end] - x[end-1]
    ra = (y[2] - y[1]) / ha
    re = (y[end] - y[end-1]) / he
    r/2 - ha*he/12 * (re - ra)
    =#
    return r/2
end
