
# Script to estimate the steady state in a chemostat given model parameters and a diltion rate -

# includes -
include("DataFile.jl")
include("FindSteadyState.jl")
using NLsolve;

# Setup dummy time scale (required by the DF) -
TSTART = 0;
TSTOP = 100;
Ts = 0.0;

# Init results array -
XSS = [];

# Load the data dictionary -
data_dictionary = DataFile(TSTART,TSTOP,Ts);

# setup diltion array -
number_of_steps = 1000;
dilution_rate_array = linspace(0,0.5,number_of_steps);
for dilution_rate in dilution_rate_array

  # copy the data file -
  data_dictionary_copy = copy(data_dictionary);

  # set the D -
  data_dictionary_copy["DILUTION_RATE"] = dilution_rate;

  # Find the steady-state -
  SS = FindSteadyState(data_dictionary_copy);

  # Grab cellmass -
  push!(XSS,SS[3]);
end
