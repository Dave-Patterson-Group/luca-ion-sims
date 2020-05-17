function plotEnergy(cloud,lineType)
if nargin < 2
    lineType = 'b';
end
times = cloud.times;
% plot(times,cloud.fracErrors,'m');
% energies = max(cloud.fracErrors) * cloud.energies / max(cloud.energies);
% hold all;
% plot(times,energies,'b');

temperatures = cloud.energies/1.3e-23;
errorString = sprintf('minimum temperature %3.3f K\nmaximum integration error %3.2e',min(temperatures),max(cloud.fracErrors));
plot(times,temperatures,lineType);

xlabel('time');
ylabel('Temperature');
if nargin == 1
    addText(errorString);
end

%Creates a plot of the total energy of the cloud (expressed as a temperature in Kelvin) as a function of time
%Generally you don't need to include the linetype arument unless you really
%want it to be a different color than blue.