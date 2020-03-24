function plotEnergy(cloud,lineType)
if nargin < 2
    lineType = 'b';
end
times = cloud.times;
% plot(times,cloud.fracErrors,'m');+6
% energies = max(cloud.fracErrors) * cloud.energies / max(cloud.energies);
% hold all;
% plot(times,energies,'b');

temperatures = cloud.energies/1.3e-23;
errorString = sprintf('minimum temperature %3.3f K\nmaximum integration error %3.2e',min(temperatures),max(cloud.fracErrors));
plot(times,temperatures,lineType);        atom.friction = 1;

xlabel('time');
ylabel('Temperature');
if nargin == 1
    addText(errorString);
end
