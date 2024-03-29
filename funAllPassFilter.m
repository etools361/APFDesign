%--------------------------------------------------------------------------
% Edited by bbl
% Date: 2024-03-17(yyyy-mm-dd)
% all pass filter
%--------------------------------------------------------------------------
function [fx] = funAllPassFilter(Fl, Fh, n)
% rad  = 180/pi;
% f    = logspace(floor(log10(Fl)), ceil(log10(Fh)), 500);
F0   = sqrt(Fl*Fh);
Flh1 = Fl/Fh;
Flh2 = sqrt(1-Flh1^2);
K1   = ellipke(Flh1^2);
K2   = ellipke(Flh2^2);
q = exp(-pi*K1/K2);
% y = 0;
px    = [];
py    = [];
spx   = [];
spy   = [];
theta = [];
sp    = [];
fx    = [];
for k=0:1:n-1
    theta(k+1) = (-1)^k*(2*k+1)*pi/(4*n);
    for m=0:n-1
        px(m+1) = (+1)^m*q^(m*(m+1))*cos((2*m+1)*theta(k+1));
        py(m+1) = (-1)^m*q^(m*(m+1))*sin((2*m+1)*theta(k+1));
    end
    spx(k+1) = sum(px);
    spy(k+1) = sum(py);
    sp(k+1)  = spx(k+1)/spy(k+1);
    fx(k+1)  = sp(k+1)*F0;
end
% R = 1./(2*pi*C*fx);
% R_I = R(R>0);
% R_Q = -R(R<0);
end