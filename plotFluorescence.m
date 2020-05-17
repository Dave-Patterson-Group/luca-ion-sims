function plotFluorescence(ionCloud,timeSpan)
if nargin < 2
    timeSpan = [0 ionCloud.times(end)];
end
figure('Position',[600   200   1000   600]);
fluor = idealFluorescence(ionCloud,timeSpan);
times = linspace(timeSpan(1),timeSpan(2),length(fluor));
plot(times,fluor);
xlabel('time');
ylabel('photons per second');
title(sprintf('Fluorescence'));

%Plots the fluorescence of the strontium ions in the cloud as a function of
%time, within the timeSpan [startTime endTime]. This fluorescence is
%calculated in the function idealFluorescence(), and is only nonzero when
%the doppler cooling is turned on, as expected.