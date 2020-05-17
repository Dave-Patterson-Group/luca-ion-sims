function [Ftransform,freqs] = fourier(x,times)
L = length(x);
if mod(L,2) == 1
    L = L - 1;
    x = x(1:L);
    times = times(1:L);
end
y = fft(x);
Y = abs(y);
p = Y(1:L/2 +1);
p(2:end-1) = 2*p(2:end-1);
deltaT = times(2)-times(1);
deltaF = 1/deltaT;
f = deltaF*(0:(L/2))/L;

Ftransform = f;
freqs = p;


% Given a signal x and its time domain times, this function returns its
% fourier transform Ftransform and frequency domain freqs