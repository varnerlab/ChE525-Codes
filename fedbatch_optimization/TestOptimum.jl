using PyPlot;

# Setup the simulation parameters -
TSTART = 0.0;
TSTOP = 36.0;
Ts = 0.1;
data_dictionary = DataFile(TSTART,TSTOP,Ts);

# What is my batch time ?
BATCH_TIME = 5;
WIDTH = 1;

# Script to test the estimated optimum -
flow_rate_array = result.minimum;

# estimate the corrected flow rate -
number_of_steps = length(flow_rate_array);
step_index_array = collect(1:number_of_steps);
for step_index in step_index_array
  if (step_index<=BATCH_TIME*WIDTH)
    flow_rate_array[step_index] = 0.0;
  end
end

# Add the flow rate aray to the data dictionary -
flow_rate_time = collect(0:0.5:36);
array = [flow_rate_time flow_rate_array];
data_dictionary["FLOW_RATE_ARRAY"] = array;

# Run the model -
flow_function = DyanmicInterpFlow;
(T,X) = SolveBalances(TSTART,TSTOP,Ts,data_dictionary,flow_function);

plot(T,X[:,2],"b",linewidth=2);

number_of_time_steps = length(T);
DARR = [];
for time_step_index in collect(1:number_of_time_steps)

  time_value = T[time_step_index];
  x_array = X[time_step_index,:];
  volumetric_flow_rate = flow_function(time_value,x_array,data_dictionary);
  push!(DARR,volumetric_flow_rate[5]);
end

# Calculuate the product productivity -
product_productivity = DARR.*X[:,2];

# Plot the dilution rate versus cellmass -
plot(T,product_productivity,"r",linewidth=2);
