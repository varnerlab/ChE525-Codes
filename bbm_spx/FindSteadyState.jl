include("SolveBalances.jl")
include("SSBalances.jl")

function FindSteadyState(data_dictionary)

  # Initialize -
  loop_flag = true;
  TSTOP_NEXT = 0.0;
  Ts = 1.0;

  # main loop -
  while (loop_flag)

    ## PHASE 1 --
    TSTART_NEXT = TSTOP_NEXT;
    TSTOP_NEXT = TSTART_NEXT + 100;

    # Evaluate the model equations -
    (TP1,XP1) = SolveBalances(TSTART_NEXT,TSTOP_NEXT,Ts,data_dictionary);


    ## PHASE 2 -

    # Reset the IC -
    X_LAST_STEP = vec(transpose(XP1[end,:]));
    data_dictionary["INITIAL_CONDITION_ARRAY"] = X_LAST_STEP;

    TSTART_NEXT = TSTOP_NEXT + Ts;
    TSTOP_NEXT = TSTART_NEXT + 100;

    # Evaluate the model equations -
    (TP2,XP2) = SolveBalances(TSTART_NEXT,TSTOP_NEXT,Ts,data_dictionary);

    # What is the difference between XP1 ands XP2?
    ERROR = norm(XP1 - XP2);

    # Check the condition -
    if (ERROR<0.01)
      loop_flag = false;

      XSS = vec(transpose(XP2[end,:]));
      return XSS;
    end
  end
end
