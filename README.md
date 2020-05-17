# luca-ion-sims
Learning github, I figured a good way to learn would be to create a repo for the simulations I've been working on. Feel free to look around, but not everything is completely up to date, so I can't guarantee all of it will work. This is just testing out github. I'll eventually clean everything up and write proper documentation so that other people can learn how to use this code.

I added an example script, EXAMPLEshowcrystallize.m, for anyone who wants to try out the simulations for themselves. All you need to do is clone the repository to your local machine, open up EXAMPLEshowcrystallize.m in matlab, and just run the script. It will generate two gifs in the same directory, showing the initial motion and final motion of 1 strontium and 1 dark ion before and after a sympathetic cooling sequence. The script will likely take a while to run, maybe about an hour? It will print its progress in the command window. Feel free to contact me if you have any questions or run into any problems.

Documentation (WIP):

The purpose of this code is to simulate the motion of atomic and molecular ions in a linear Paul ion trap, in order to better understand their behavior under various external stimuli. 

There are two main types of objects used in this simulation: clouds and pulse sets. A cloud is a collection of ions in the ion trap; it contains information about each ion, like its position, velocity, mass, charge, etc. A pulse set is a collection of pulses, external stimuli which we apply to the ions. So, the basic structure of the simulation is that we start out with some initial cloud and some pulses X, Y, and Z that we want to apply to the cloud. We then tell the computer to evolve the cloud using Newton's laws, where each ion feels electrostatic repulsion from the other ions and the potential of the trap itself, as well as the pulses X, Y, and Z. This produces a final cloud, which contains all of the information contained within the initial cloud, but also includes the trajectories of the ions, how they moved from the initial cloud to the final cloud. So, from this final cloud, we can find out all of the information we want to know about how the ions reacted to the external stimuli/pulses.

