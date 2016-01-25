# Script to solve the simple model -
include("DataFile.jl")
include("SolveBalances.jl")
include("Flow.jl")

# ================================================================== #
# Phase 0 = Initialize
# ================================================================== #
data_dictionary = DataFile(0,0,0);
flow_function = FedbatchExpFlow;

# ================================================================== #
# Phase 1 = run for 24 hours
# ================================================================== #

# Setup the timescale for phase 1 -
TSTART_P1 = 0;
TSTOP_P1 = 30.0;
Ts_P1 = 0.01;

# Solve the balance equations -
(TP1,XP1) = SolveBalances(TSTART_P1,TSTOP_P1,Ts_P1,data_dictionary,flow_function);
