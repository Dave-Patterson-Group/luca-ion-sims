
function addText(tstring,ABOVE)
if (nargin == 1)
    ABOVE = 0;
end
%adds text to the current plot.
if ~isempty(tstring)
    a = xlim;
    b = ylim;
    xstart = a(1) + 0.1 * (a(2) - a(1));
    ystart = b(1) + 0.55 * (b(2) - b(1));
    if ABOVE == 1
        ystart = b(1) + 0.8 * (b(2) - b(1));
    end
    if ABOVE == -1
        ystart = b(1) + 0.2 * (b(2) - b(1));
       
    end
    if ABOVE == -2
        ystart = b(1) + 0.05 * (b(2) - b(1));
       
    end
        text(xstart,ystart,tstring,'FontSize',10,'FontWeight','normal');
       
end
