function [fracError] = rkError(y,t,h,ionCloud,fieldSet)
%returns fractional energy error 
energyStart= energy(y,ionCloud);
[newy,newt,collided] = rkStep(y,t,h,ionCloud,fieldSet);
energyEnd = energy(newy,ionCloud);
delE = abs(energyStart-energyEnd);
fracError = delE / energyStart;
