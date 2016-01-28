
# Script to estimate the steady state in a chemostat given model parameters and a diltion rate -

# includes -
include("DataFile.jl")
include("FindSteadyState.jl")
using NLsolve;

# Setup dummy time scale (required by the DF) -
TSTART = 0;
TSTOP = 100;
Ts = 0.0;
SIGMA = 0.1;

# Load the data dictionary -
data_dictionary = DataFile(TSTART,TSTOP,Ts);

# setup diltion array -
number_of_steps = 1000;
dilution_rate_array = linspace(0.01,1.0,number_of_steps);

# Setup data array -
results_array = zeros(100,4);
index = 1;
local_index = 1;
for dilution_rate in dilution_rate_array

  # copy the data file -
  data_dictionary_copy = copy(data_dictionary);

  # set the D -
  data_dictionary_copy["DILUTION_RATE"] = dilution_rate;

  # Find the steady-state -
  SS = FindSteadyState(data_dictionary_copy);

  # Grab SS data -
  if ((index % 10) == 0)
    results_array[local_index,1] = dilution_rate; # D
    results_array[local_index,2] = SS[1]*(1 + SIGMA*randn()); # Substrate
    results_array[local_index,3] = SS[2]*(1 + SIGMA*randn()); # Product
    results_array[local_index,4] = SS[3]*(1 + SIGMA*randn()); # Cellmass

    local_index += 1;
  end

  index+=1;
end

# Write results file -
filename = "DS_NoProduct.dat";
Z = round(results_array,2);
writedlm(filename,Z,"\t");
