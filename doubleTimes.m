function newTimes = doubleTimes(times)
dt = (times(2) - times(1))/ 2;
newLength = length(times) * 2;
newTimes = times(1) + ((0:(newLength-1))*dt);
