function fourierFluorescence(ionCloud,timeSpan)
if nargin < 2
    timeSpan = [0 ionCloud.times(end)];
end
fluor = idealFluorescence(ionCloud,timeSpan);
times = linspace(timeSpan(1),timeSpan(2),length(fluor));
[f,p] = fourier(fluor,times);
figure;
plot(f,p);
xlabel('Frequency (Hz)');
xlim([0 5e6]);