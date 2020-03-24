function forceSquare()
a = xlim;
b = ylim;
extent = max(abs([a b]));
xlim([-extent extent]);
ylim([-extent extent]);
