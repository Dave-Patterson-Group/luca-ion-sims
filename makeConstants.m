function c = makeConstants
%example: twospins(1,0.5);
c.H = 6.626068766e-34;                  %in SI
c.HBAR = c.H/(2 * pi);                  %in SI
c.C = 2.99792458e8;                     %in m/s
c.E = 1.602176462e-19;                  %in Coulombs
c.BOHRMAGNETON = 9.274009994e-24;       %in Joules/Tesla
c.BOHRMAGNETONHZ = c.BOHRMAGNETON/c.H;  %in Hz/Tesla
c.BOLTZMANN = 1.380650e-23;             %in SI
c.AMU = 1.66e-27;