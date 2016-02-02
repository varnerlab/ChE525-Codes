function correctBigChanges(flow_rate_array)

  # initialize -
  FARRAY = copy(flow_rate_array);

  # What are th differences?
  diff_flow_rate = diff(flow_rate_array);
  idx_large_diff = find(abs(diff_flow_rate).>MAX_DELTA);
  number_of_large_differences = length(idx_large_diff);
  for large_diff_index in collect(1:number_of_large_differences)

    # get the diff value -
    local_difference_index = idx_large_diff[large_diff_index];
    value = diff_flow_rate[local_difference_index];

    if (value>0)
      FARRAY[local_difference_index+1] = MAX_DELTA + flow_rate_array[local_difference_index];
    else
      FARRAY[local_difference_index+1] = abs(flow_rate_array[local_difference_index] - MAX_DELTA);
    end
  end


  return FARRAY;
end
