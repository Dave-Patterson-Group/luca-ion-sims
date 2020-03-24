function EXAMPLEshowCrystallize()

%This simulation is one of the simplest possible procedures: Start with 1
%strontium (blue) and 1 dark ion (red), laser cool, and let the strontium
%sympathetically cool the dark ion until they form a crystal. 

initCloud = initializeCloud(2,1,'customZ',100,100.1,5e4); % Creates a cloud with 2 ions, 1 of them Sr, with axial (z) secular freq of 50 kHz
pulseSet1 = addThermalize({},[0 4e-4],0.05,100,1.5,-100e6); % Initializes cloud with a bit of random noise, and laser cooling red-detuned 100 MHz
intermediateCloud = evolveCloud(initCloud,pulseSet1,40e-3); % Evolves the initial cloud for 40 ms
pulseSet2 = addFrictionPulse({},[0 20e-3],1.5,-25e6); % Laser cooling red-detuned 25 MHz
finalCloud = evolveCloud(intermediateCloud,pulseSet2,20e-3); % Evolves the intermediate cloud for 20 ms

%The following creates two gifs in your current directory, showing the
%initial and final motion of the ions before and after the cooling
%sequence.
animated2dTrajectory(intermediateCloud,'z','x',[0.0e-3 0.5e-3],'initCrystal2.gif'); 
animated2dTrajectory(finalCloud,'z','x',[19.5e-3 20.0e-3],'finalCrystal2.gif'); 
