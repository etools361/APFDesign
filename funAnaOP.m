%--------------------------------------------------------------------------
% Edited by bbl
% Date: 2024-03-17(yyyy-mm-dd)
% OP APF analysis
%--------------------------------------------------------------------------
function [ang, Suppression] = funAnaOP(R, C, f)
ang = 0;
fx = 1./(2*pi.*R.*C);
n  = length(fx);
for k=1:n
    ang = ang - 2*atan(f/fx(k));
end
Suppression = 20*log10(cot((ang-pi/2)/2));
end