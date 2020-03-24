function i = findIndex(times,t)
dt = times(2) - times(1);
i = (t - times(1))/dt;
i = round(i+1);
i = min(i,length(times));
