function v = doubleLength(v)
sz = size(v);
newlength = length(v) * 2;
if sz(1) > sz(2)
    v(newlength,1) = 0;
else
    v(1,newlength) = 0;
end
