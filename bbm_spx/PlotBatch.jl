using PyPlot;

# Plot the dilution rate versus cellmass -
plot(TP1,XP1[:,1],"b",linewidth=2.0);
plot(TP1,XP1[:,3],"r",linewidth=2.0);

# axis -
xlabel("Time [hr]");
ylabel("Cellmass [gdw/L] or Substrate [mmol/L]");

# export -
savefig("Batch-2.pdf")
