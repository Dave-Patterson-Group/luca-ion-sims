function plotFields(cloud)
%whichToPlot = whichFields(fieldSet);
%numToPlot = length(whichToPlot);
fieldSet = cloud.fieldSet;
zPotentialTime = cloud.zPotentialTime;

figure('Position',[200   100   600   500]);
t = fieldSet.times;

subplot((zPotentialTime.zChanges + 4),1,1);
plot(t,fieldSet.frictionx * 1e20);
hold all;
plot(t,fieldSet.frictiony * 1e20);
plot(t,fieldSet.frictionz * 1e20);
legend('Friction x','Friction y','Friction z');

subplot((zPotentialTime.zChanges + 4),1,2);
plot(t,fieldSet.Ex * 1e20);
hold all;
plot(t,fieldSet.Ey * 1e20);
plot(t,fieldSet.Ez * 1e20);
legend('Ex','Ey','Ez');

subplot((zPotentialTime.zChanges + 4),1,3);
plot(t,fieldSet.opticalx * 1e20);
hold all;
plot(t,fieldSet.opticaly * 1e20);
plot(t,fieldSet.opticalz * 1e20);
legend('opticalx','opticaly','opticalz');

subplot((zPotentialTime.zChanges + 4),1,4);
plot(t,fieldSet.E2x * 1e20);
hold all;
plot(t,fieldSet.E2y * 1e20);
plot(t,fieldSet.E2z * 1e20);
legend('squeezex','squeezey','squeezez');

if zPotentialTime.zChanges
    subplot(5,1,5);
    plot(zPotentialTime.zTimes,zPotentialTime.zPot);
    hold all;
    legend('Z Potential');
end
