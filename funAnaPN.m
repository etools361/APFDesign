%--------------------------------------------------------------------------
% Edited by bbl
% Date: 2024-03-17(yyyy-mm-dd)
% PolyPhaseNetwork analysis
%--------------------------------------------------------------------------
function [ang, Suppression] = funAnaPN(R, C, RL, ft)
n = length(R);
N = length(ft);
L = [1/RL(1),      0,       0,       0;
           0,1/RL(1),       0,       0;
           0,      0, 1/RL(1),       0;
           0,      0,       0, 1/RL(1);];
I = [      1,      0,       0,       0;
           0,      1,       0,       0;
           0,      0,       1,       0;
           0,      0,       0,       1;];
Vin = [    1;
           1;
          -1;
          -1;];
for ii=1:N
    f = ft(ii);
    A = MA(R(1),C(1),2*pi*f);
    for m = 2:n
        Ax = MA(R(m),C(m),2*pi*f);
        A = A*Ax;
    end
    A11 = A(1:4,1:4);
    A12 = A(1:4,5:8);
    A21 = A(5:8,1:4);
    A22 = A(5:8,5:8);
    Vout = (I-A12/A22*L)\(A11-A12/A22*A21)*Vin;
    Va(ii) = Vout(3)-Vout(1);
    Vb(ii) = Vout(4)-Vout(2);
end
ang = angle(Va./Vb);
Suppression = 20*log10(abs(cot((ang-pi/2)/2)));






              