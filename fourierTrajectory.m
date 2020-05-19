function fourierTrajectory(cloud,dim)   
x = pullTrajectory(cloud,dim); %dim = 'x1','y1','z1','x2','y2','z2', etc.
times = cloud.times;
[f,p] = fourier(x,times);
figure;
plot(f,p);
xlabel('Frequency (Hz)');
xlim([0,5e6]);

%This function plots the fourier transform of the trajectory of an ion.
%For example, if wanted to know what frequency the 2nd ion in the cloud was 
%oscillating in the z-direction, you would call
%fourierTrajectory(cloud,'z2');