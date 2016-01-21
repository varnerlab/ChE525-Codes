using PyPlot;

# Plot the dilution rate versus cellmass -
plot(dilution_rate_array,XSS,"b");

# axis -
xlabel("Dilution rate [1/hr]");
ylabel("Cellmass [gdw/L] or Cellmass productivity [gdw/L-hr]");

# Plot the productivity -
productivity = dilution_rate_array.*XSS;
plot(dilution_rate_array,productivity,"r");
