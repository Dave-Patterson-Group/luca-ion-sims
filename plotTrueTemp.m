function plotTrueTemp(cloud,lineType)
figure('Position',[600   200   600   400]);
if nargin < 2
    lineType = 'b';
end
times = cloud.times;
temperatures = (cloud.energies)/(cloud.numAtoms * 1.3e-23);
plot(times,temperatures,lineType);
xlabel('time');
ylabel('Temperature');
