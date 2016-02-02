using PyPlot;

# get stuff from results array -
dilution_rate_array = results_array[:,1];
PSS = results_array[:,3];
XSS = results_array[:,4];

# Plot the dilution rate versus cellmass -
plot(dilution_rate_array,XSS,"b",linewidth=2);

# Plot the product -
plot(dilution_rate_array,PSS,"g",linewidth=2);

# axis -
xlabel("Dilution rate D [1/hr]");
ylabel("Cellmass [gdw/L], Product [mmol/L] and Product productivity [mmol/L-hr]");

# Plot the productivity -
product_productivity = dilution_rate_array.*PSS;
plot(dilution_rate_array,product_productivity,"r",linewidth=2);

# export -
savefig("Productivity-Chemostat.pdf");
