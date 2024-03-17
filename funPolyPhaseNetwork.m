%--------------------------------------------------------------------------
% Edited by bbl
% Date: 2024-03-17(yyyy-mm-dd)
% all pass filter
%--------------------------------------------------------------------------
function [fx] = funPolyPhaseNetwork(Fl, Fh, n)
Flh1 = Fl/Fh;
ek   = 1-Flh1^2;
fx   = [];
K    = ellipke(ek);
for k=1:n
    [sn, cn, dn] = ellipj((2*k-1)/(2*n)*K,ek);
    fx(k) = Fl/dn;
end

end