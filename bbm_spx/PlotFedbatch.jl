using PyPlot;

# Plot the dilution rate versus cellmass -
plot(TP1,abs(XP1[:,1]),"b",linewidth=2.0);
plot(TP1,XP1[:,2],"g",linewidth=2.0);
plot(TP1,XP1[:,3],"r",linewidth=2.0);


# axis -
xlabel("Time [hr]");
ylabel("Cellmass [gdw/L] or Substrate/Product [mmol/L]");

# export -
savefig("FedBatch-C3.pdf");
