function finalCloud = EXAMPLEshowCrystallize()

%This simulation is one of the simplest possible procedures: Start with 2
%strontium (blue in the gifs) and 1 dark ion (red in the gifs), laser cool, 
%and let the strontium sympathetically cool the dark ion until they form a crystal. 

initCloud = initializeCloud(2,1,100e3,101e3,55e3,92);
% Creates a cloud with 2 Sr ions and 1 dark ion, with radial frequency of ~100 kHz 
% (not exactly the same in x and y, to simulate imperfect trap geometry), and axial
% secular frequency 55 kHz. The dark ion has a mass of 92 AMU

pulseSet = pulseSetInitialCooldown100ms({});
% Creates a pulseSet that just cools down the ions over a period of 100e-3
% seconds, starting with a high red-detuning of 100 MHz, then slowly turning it
% down as the ions cool

finalCloud = evolveCloud(initCloud,pulseSet,100e-3); 
% Evolves the initial cloud for 50 ms, returning a final cloud

%The following creates two gifs in your current directory, showing the
%initial and final motion of the ions before and after the cooling
%sequence.
animated2dTrajectory(finalCloud,'z','x',[0.0e-3 0.5e-3],'initialCloud.gif'); 
animated2dTrajectory(finalCloud,'z','x',[99.5e-3 100.0e-3],'finalCrystal.gif'); 


%This simulation will take a long time to run, probably about an hour. Any
%time you need to cool down a hot cloud, it will take a long time to
%simulate properly. You can get around this by either saving already cooled
%clouds as .mat files and just loading those so you don't need to cool down
%every time, or you can manually go into the ionCloud.vector object, and
%set the velocities to zero and the positions close to equilibrium. I
%recommend the first option. At some point I'll upload a bunch of useful
%pre-loaded clouds to github.