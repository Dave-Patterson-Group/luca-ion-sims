function plotIndividualEnergies(cloud)
figure('Position',[600   200   600   400]);
times = cloud.times;
individualTemperatures = cloud.individualEnergies/1.3e-23;
for i = 1:cloud.numAtoms
    plot(times,individualTemperatures(i,:));
    hold on
end

xlabel('time');
ylabel('Temperature of Each Ion');
