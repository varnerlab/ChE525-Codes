# Load the model files -
include("DataFile.jl");
include("Flow.jl");
include("SolveBalances.jl");
include("Objective.jl")

# We are going to use the SA lib in Optim -
using Optim;

# Setup the simulation parameters -
TSTART = 0.0;
TSTOP = 36.0;
Ts = 0.1;
data_dictionary = DataFile(TSTART,TSTOP,Ts);

# Setup optimization calculation -
objective_function(flow_array) = Objective(flow_array,TSTART,TSTOP,Ts,data_dictionary);

# Run the opimizer -
initial_flow_array = ones(36*2+1);
result = optimize(objective_function,initial_flow_array,method= :simulated_annealing, iterations = 2000,show_trace=true);
