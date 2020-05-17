# luca-ion-sims

The purpose of this code is to simulate the dynamics of ions in a linear Paul ion trap.
Everything in this code is in SI units unless explicitly stated otherwise.
The coordinates here are x,y corresponding to the radial directions, and z the axial direction.

There are two main types of objects in this code: clouds, and pulses.
A cloud is an object that contains all of the information about the collection of ions, including their position, velocity, which are strontium and which are dark, etc.
A pulse is an external stimuli that is applied to the cloud, like doppler cooling, electric fields, optical tweezers, etc. Pulses are collected together in objects called pulseSets.

To run a simulation, you can either create a new Matlab function with all of the commands in it, or you can just directly type the commands into the command window, and all of the variables will be saved to the workspace.
For an example of the former, see the function EXAMPLEshowCrystallize()
For any simulation you want to run, there are 4 basic steps:

Step 1: Initializing the cloud
In order to start a simulation, you need to create a cloud using the function initializeCloud(), as follows:

myFirstCloud = initializeCloud(numSr,numDark,xPot,yPot,zPot,darkMass,micro);

Where the following inputs are required:

numSr (int) is the number of strontium ions (which can be doppler cooled)
numDark (int) is the number of dark ions (which do not feel doppler cooling)

and the following inputs are optional:

xPot (float) is the secular frequency of strontium ions in the x-direction (default is 100e3 Hz)
yPot (float) is the secular frequency of strontium ions in the y-direction (default is 101e3 Hz)
zPot (float) is the secular frequency of strontium ions in the z-direction (default is 55e3 Hz)
darkMass (int) is the mass of the dark ions in AMU (default is 89)
micro (logical 1 or 0) determines whether micromotions are turned on (1) or off (0) (default is 1)

For example, you could have myFirstCloud = initializeCloud(2,1,150e3,160e3,73e3,104,1);

Step 2: Generating the pulseSet
Next, you need to specify what kinds of stimuli you want to apply to the ions.
Begin by creating an empty cell pulseSet = {};
Then, just add to it with pulseSet{end+1} = pulseExamplePulse(parameters);
The following functions are all pulses you can add. Descriptions of each are commented in their code.

pulseCooling()

pulseEfield()

pulseTweezer()

pulseEnoise()

pulseChirp()

pulseSqueeze()

pulseSlap()


You can also use pulseSet functions, which are just shortcuts for adding multiple pulses to the pulseSet at once: pulseSet = pulseSetExample(pulseSet,otherParameters);
The following functions are pulseSet functions:

pulseSetCooling()

pulseSetInitialCooldown100ms()

pulseSetInitialCooldown50ms()

pulseSetThermalize()

pulseSetSlapShot()


You should end up with a cell pulseSet that contains each of the individual pulses. For example, you could have:
pulseSet = pulseCooling({},1.5,10e-3);
pulseSet{end+1} = pulseEfield(1e-20,55e3);


Step 3: Evolving the cloud
Once you have an initialized cloud and a pulseSet, you evolve the cloud through time via the evolveCloud() function, which returns a new cloud with the same kinds of properties as the initial cloud, plus some extra ones, including a list of trajectories of the individual ions as they evolved through time.

myEvolvedCloud = evolveCloud(myFirstCloud,pulseSet,t,zFreq);

where the following inputs are required

myFirstCloud (cloud) is the initial cloud, with the initial state and information about all of the ions.
pulseSet (pulseSet) is the pulseSet as described previously, containing all of the pulses applied to the ions.
t (float) is the amount of time you evolve the cloud for, in seconds. Generally you don't want to evolve a single cloud for more than about a second, otherwise the arrays get too big and everything slows down. Most phenomena occur in the ~millisecond regime anyways.

and the following input is optional

zFreq (float) is a new axial secular frequency. If you include this parameter, while the cloud is evolving, the axial secular frequency will increase or decrease linearly with time from its initial value at time = 0 (as specified in zPot in initializeCloud) to this final value zFreq at time = t. This corresponds to slowly increasing or decreasing the voltage on the endcap electrodes, creating a tighter or looser trap. For most simulations, you'll just not include this 4th argument. That keeps the axial secular frequency static.


For example, you could have myEvolvedCloud = evolveCloud(myFirstCloud,pulseSet,10e-3);


Step 4: Extracting info from the evolved cloud
After you evolve the cloud through time, you're left with a final cloud, containing lots of information about what the ions have been doing.
To extract this information and learn about the dynamics of the ions, you can use the following functions. Descriptions of each are commented in their code:
 
animated2dTrajectory()

plot2dTrajectory()

plotEnergy()

plotFluorescence()

plotIndividualEnergies()

plotJustTrajectories()

plotJustZ()

plotXYZ()

plotTrajectories()

fourierTrajectory()

getZPosition()

getZVector()


If you learn how the ion clouds are structured and what everything means, you can also just open up the clouds in the Matlab workspace and find or plot whatever you want. This is rarely necessary though, these functions should cover most if not all of the useful information you can get out of a cloud.



It's always possible that I've missed something, or there's a bug, or some code which badly needs commenting that I forgot to comment, or an explanation I wrote is unclear. If you find anything like this, or if you just have any questions about this code in general, please feel free to contact me! Message me on slack, or email me at lscharrer@ucsb.edu

Best of luck!

 - Luca Scharrer
