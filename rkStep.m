function [newy,newt,collided] = rkStep(y,t,h,ionCloud,fieldSet)
collided = zeros(1,ionCloud.numIons);
if ionCloud.bufferGasBool
    for i = 1:ionCloud.numIons
        vecPos = (i-1) * 6;
        const = makeConstants();
        mHe = 4.0026 * const.AMU;
        tempHe = ionCloud.bufferGasTemp; %Kelvin
        d = 580e-12; %meters
        atomSpeedSquared = (y(vecPos+4))^2 + (y(vecPos+5))^2 + (y(vecPos+6))^2;
        meanFreePathTime = 1 / (((atomSpeedSquared + (3 * const.BOLTZMANN * tempHe / mHe))^(1/2)) * pi * d * d * ionCloud.bufferGasDensity * 1e6);
        
        if (t > ionCloud.bufferGasTime(1)) && (t < ionCloud.bufferGasTime(2))
            p = 1.697688e-8 / meanFreePathTime;
            n = rand;
            if n <= p                
                collided(i) = 1;
            end
        end
    end
end
    
k1 = h * ydot(t,y,ionCloud,fieldSet,collided);  %use only k1 for zeros order R-K
k2 = h * ydot(t+h/2,y+k1/2,ionCloud,fieldSet,collided);
k3 = h * ydot(t+h/2,y+k2/2,ionCloud,fieldSet,collided);
k4 = h * ydot(t+h,y+k3,ionCloud,fieldSet,collided);
newy = y + ((k1 + (2*k2) + (2*k3) + k4) /6); %this line is RK4
newt = t + h;
