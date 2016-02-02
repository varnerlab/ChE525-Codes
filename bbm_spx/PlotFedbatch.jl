include("Flow.jl")
using PyPlot;

# Calculate the dulution rate -
data_dictionary = DataFile(0,0,0);
flow_function = FedbatchExpFlow;

number_of_time_steps = length(TP1);
DARR = [];
for time_step_index in collect(1:number_of_time_steps)

  time_value = TP1[time_step_index];
  x_array = XP1[time_step_index,:];
  volumetric_flow_rate = flow_function(time_value,x_array,data_dictionary);
  push!(DARR,volumetric_flow_rate[5]);
end

# Calculuate the product productivity -
product_productivity = DARR.*XP1[:,2];

# Plot the dilution rate versus cellmass -
plot(TP1,product_productivity,"r",linewidth=2);

# axis -
xlabel("Time [hr]");
ylabel("Product productivity [mmol/L-hr]");

# export -
savefig("Productivity-FedBatch.pdf");
