function plotFinalTemps(tickleFrequencies,finalTemps)
figure('Position',[100   100   500   500],'Name',sprintf('Final Temperatures vs Frequency'));
plot(tickleFrequencies,finalTemps,'b');
xlabel('Tickle Frequency');
ylabel('Final Temperature');
