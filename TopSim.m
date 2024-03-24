%--------------------------------------------------------------------------
% Edited by bbl
% Date: 2024-03-23(yyyy-mm-dd)
% simplify eq
%--------------------------------------------------------------------------
syms R1 C1 RL R2 C2 R3 C3 w
I = [      1,      0,       0,       0;
           0,      1,       0,       0;
           0,      0,       1,       0;
           0,      0,       0,       1;];
% L = [1/RL,      0,       0,       0;
%            0,1/RL,       0,       0;
%            0,      0, 1/RL,       0;
%            0,      0,       0, 1/RL;];
L = [0,      0,       0,       0;
           0,0,       0,       0;
           0,      0, 0,       0;
           0,      0,       0, 0;];
Vin = [    1;
           1;
          -1;
          -1;];

[A1] = MA(R1,C1,w);
[A2] = MA(R2,C2,w);
[A3] = MA(R3,C3,w);
A = A1*A2*A3;
A11 = A(1:4,1:4)
A12 = A(1:4,5:8)
A21 = A(5:8,1:4)
A22 = A(5:8,5:8)



% Vout = (I-A12/A22*L)\(A11-A12/A22*A21)*Vin
Vout = A11*Vin-A12/A22*A21*Vin;
              
Va = Vout(3)-Vout(1);
Vb = Vout(4)-Vout(2);
sVa = simplify(Va);
sVb = simplify(Vb);
sVab = sVa/sVb;
ssVab = simplify(sVab)
pretty(ssVab)
