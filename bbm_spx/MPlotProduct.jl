using PyCall;
PyDict(pyimport("matplotlib")["rcParams"])["font.sans-serif"] = ["Arial"]
using PyPlot;
using LsqFit;

filename = "DS_Product.dat";
data_set = readdlm(filename);
dilution_col_index = 1;
substrate_col_index = 2;
product_col_index = 3;
cellmass_col_index = 4;

# calculate the app yield -
(rows,cols) = size(data_set);
row_index_array = collect(1:rows);

YAPP = Array(Float64,1);
DARR = Array(Float64,1);
for row_index in row_index_array

  dilution_value = data_set[row_index,dilution_col_index];
  delta_s = data_set[end,substrate_col_index] - data_set[row_index,substrate_col_index];
  delta_x = data_set[row_index,cellmass_col_index];
  value = delta_x/delta_s;

  if (value>0 && dilution_value>0)
    push!(YAPP,1/value);
    push!(DARR,1/dilution_value);
  end

end

# Estimate linear model -
linear_model(x,p) = p[2].*x + p[1];
fit = fit = curve_fit(linear_model,vec(DARR),vec(YAPP),[1.0,1.0]);
estimated_parameters = fit.param;
yestimated = linear_model(vec(DARR),estimated_parameters);

# setup of fonts -


# plot -
plot(DARR,YAPP,"ro");
plot(DARR,yestimated,"b");
xlabel("D [hr]",fontsize=18);
ylabel("Inverse apparent yield [mmol/gdw]",fontsize=18);
