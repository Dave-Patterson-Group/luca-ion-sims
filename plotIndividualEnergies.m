function plotIndividualEnergies(cloud)
figure('Position',[600   200   600   400]);
times = cloud.times;
individualTemperatures = cloud.individualEnergies/1.3e-23;
for i = 1:cloud.numIons
    plot(times,individualTemperatures(i,:));
    hold on
end

xlabel('time');
ylabel('Temperature of Each Ion');

%This makes a plot of the energy of each individual ion as a function of
%time. Keep in mind, in these plots, the energy of each ion is the sum of
%the kinetic energy, the potential energy due to the trap, and the
%potential energy of the ion due to the E fields of all of the other ions
%(treating the other ions as an external potential). This means that if you
%were to sum all of the individual energies of the ions, it will be greater
%than the total energy of the cloud, due to overcounting the energy from the
%Coulomb interaction. That's not really a problem for most of the use cases
%of this function, but you should keep this in mind when using it!