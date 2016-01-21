using PyCall
@pyimport numpy as np

# ----------------------------------------------------------------------------------- #
# Copyright (c) 2016 Varnerlab
# School of Chemical Engineering Purdue University
# W. Lafayette IN 46907 USA
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# ----------------------------------------------------------------------------------- #
function BatchFlow(t,x,data_dictionary)

  # For batch, there is no flow -
  flow_vector = zeros(4);
  
  # return -
  return flow_vector;
end

function SteadyStateFlow(t,x,data_dictionary)

  # Alias the species vector -
  S = x[1];
  P = x[2];
  X = x[3];
  V = x[4];

  # Get parameters from the data file -
  parameter_array = data_dictionary["FEED_PARAMETER_ARRAY"];
  SIN = parameter_array[1];
  PIN = parameter_array[2];
  XIN = parameter_array[3];

  # Get the dilution rate -
  D = data_dictionary["DILUTION_RATE"];
  DIN = D;
  DOUT = D;

  # initialize the flow vector -
  flow_vector = zeros(4);
  flow_vector[1] = DIN*SIN - DOUT*S;
  flow_vector[2] = DIN*PIN - DOUT*P;
  flow_vector[3] = DIN*XIN - DOUT*X;
  flow_vector[4] = DIN - DOUT;

  # return -
  return flow_vector;

end


function DyanmicFlow(t,x,data_dictionary)

  # Alias the species vector -
  S = x[1];
  P = x[2];
  X = x[3];
  V = x[4];

  # Get parameters from the data file -
  parameter_array = data_dictionary["FEED_PARAMETER_ARRAY"];
  SIN = parameter_array[1];
  PIN = parameter_array[2];
  XIN = parameter_array[3];

  # Get the volumetric flow rate array -
  flow_rate_array = data_dictionary["FLOW_RATE_ARRAY"];
  time_array = flow_rate_array[:,1];
  FIN_array = flow_rate_array[:,2];
  FOUT_array = flow_rate_array[:,3];

  # interpolate the FIN and FOUT to the current time point -
  I_FIN = np.interp(t,time_array,FIN_array);
  I_FOUT = np.interp(t,time_array,FOUT_array);

  # Calculate the dilution rate -
  DIN = I_FIN/V;
  DOUT = I_FOUT/V;

  # initialize the flow vector -
  flow_vector = zeros(4);
  flow_vector[1] = DIN*SIN - DOUT*S;
  flow_vector[2] = DIN*PIN - DOUT*P;
  flow_vector[3] = DIN*XIN - DOUT*X;
  flow_vector[4] = DIN - DOUT;

  # return -
  return flow_vector;
end
