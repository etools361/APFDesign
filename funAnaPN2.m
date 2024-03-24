%--------------------------------------------------------------------------
% Edited by bbl
% Date: 2024-03-17(yyyy-mm-dd)
% PolyPhaseNetwork analysis
%--------------------------------------------------------------------------
function [ang, Suppression] = funAnaPN2(R, C, RL, ft)
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
M0 = [0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];
Vini = [0;0;0;0];
for ii=1:N
    f = ft(ii);
    [A11r, A11i,A12r,A12i,A21r,A21i,A22r,A22i] = MA2(R(1),C(1),f);
%     Ar   = [A11r,A12r;A21r,A22r];
%     Ai   = [A11i,A12i;A21i,A22i];
%     A    = Ar+1i*Ai;
    for m = 2:n
        [Ax11r, Ax11i,Ax12r,Ax12i,Ax21r,Ax21i,Ax22r,Ax22i] = MA2(R(m),C(m),f);
%         Axr   = [Ax11r,Ax12r;Ax21r,Ax22r];
%         Axi   = [Ax11i,Ax12i;Ax21i,Ax22i];
%         Ax    = Axr+1i*Axi;
%         A = A*Ax;
        [Ax11rmut, Ax11imut] = funCMmut(A11r, A11i, Ax11r, Ax11i);
        [Ax12rmut, Ax12imut] = funCMmut(A12r, A12i, Ax21r, Ax21i);
        [A11ro, A11io] = funCMsum(Ax11rmut, Ax11imut, Ax12rmut, Ax12imut);
        [Ax11rmut, Ax11imut] = funCMmut(A11r, A11i, Ax12r, Ax12i);
        [Ax12rmut, Ax12imut] = funCMmut(A12r, A12i, Ax22r, Ax22i);
        [A12ro, A12io] = funCMsum(Ax11rmut, Ax11imut, Ax12rmut, Ax12imut);
        [Ax11rmut, Ax11imut] = funCMmut(A21r, A21i, Ax11r, Ax11i);
        [Ax12rmut, Ax12imut] = funCMmut(A22r, A22i, Ax21r, Ax21i);
        [A21ro, A21io] = funCMsum(Ax11rmut, Ax11imut, Ax12rmut, Ax12imut);
        [Ax11rmut, Ax11imut] = funCMmut(A21r, A21i, Ax12r, Ax12i);
        [Ax12rmut, Ax12imut] = funCMmut(A22r, A22i, Ax22r, Ax22i);
        [A22ro, A22io] = funCMsum(Ax11rmut, Ax11imut, Ax12rmut, Ax12imut);
        A11r = A11ro;
        A11i = A11io;
        A12r = A12ro;
        A12i = A12io;
        A21r = A21ro;
        A21i = A21io;
        A22r = A22ro;
        A22i = A22io;
%         [Ar, Ai] = funCMmut(Ar, Ai, Axr, Axi);
    end
%         A11 = A(1:4,1:4);
%         A12 = A(1:4,5:8);
%         A21 = A(5:8,1:4);
%         A22 = A(5:8,5:8);
%     A11 = A11r+1i*A11i;
%     A12 = A12r+1i*A12i;
%     A21 = A21r+1i*A21i;
%     A22 = A22r+1i*A22i;
%     Vout = (I-A12/A22*L)\(A11-A12/A22*A21)*Vin;
%     Va(ii) = Vout(3)-Vout(1);
%     Vb(ii) = Vout(4)-Vout(2);

%     invA22 = inv(A22);
%     T2 = A12*invA22;
%     Vout = inv(I-T2*L)*(A11-T2*A21)*Vin;
    
    [invA22r, invA22i] = funCMinv(A22r, A22i);
    [T2r, T2i] = funCMmut(A12r, A12i, invA22r, invA22i);
    [T2Lr, T2Li] = funCMmut(T2r, T2i, L, M0);
    [IT2Lr,IT2Li] = funCMsub(I,M0,T2Lr,T2Li);
    [invIT2Lr,invIT2Li]=funCMinv(IT2Lr,IT2Li);
    [T2A21r, T2A21i] = funCMmut(T2r, T2i, A21r, A21i);
    [A11T2A21r,A11T2A21i] = funCMsub(A11r,A11i,T2A21r, T2A21i);
    [T3r, T3i] = funCMmut(invIT2Lr,invIT2Li, A11T2A21r,A11T2A21i);
    [Voutr, Vouti] = funCMmut(T3r, T3i, Vin, Vini);
    Vout = Voutr+1i*Vouti;
    Va(ii) = Vout(3)-Vout(1);
    Vb(ii) = Vout(4)-Vout(2);
end
ang = angle(Va./Vb);
Suppression = 20*log10(cot((ang-pi/2)/2));

function [A11r,A11i,A12r,A12i,A21r,A21i,A22r,A22i] = MA2(R1, C1, f)
w = 2*pi*f;
M11r = [1/R1,            0,           0,             0;
                  0, 1/R1,           0,             0;
                  0,            0, 1/R1,            0;
                  0,            0,            0, 1/R1];
M12r = -M11r;
M21r =  M11r;
M22r = -M11r;
M11i = w*[       C1,            0,           0,             0;
                  0,           C1,           0,             0;
                  0,            0,          C1,             0;
                  0,            0,           0,            C1];
M12i = -w*[       0,            0,           0,            C1;
                 C1,            0,           0,             0;
                  0,           C1,           0,             0;
                  0,            0,          C1,             0];
M21i = w*[        0,           C1,           0,             0;
                  0,            0,          C1,             0;
                  0,            0,           0,            C1;
                 C1,            0,           0,             0];
M22i = -w*[      C1,            0,           0,             0;
                  0,           C1,           0,             0;
                  0,            0,          C1,             0;
                  0,            0,           0,            C1];

[A12r, A12i] = funCMinv(M12r, M12i);

[A11r, A11i] = funCMmut(-A12r, -A12i, M11r, M11i);

[A22r, A22i] = funCMmut(M22r, M22i, A12r, A12i);

[Tr, Ti] = funCMmut(M22r, M22i, A11r, A11i);
[A21r, A21i] = funCMsub(M21r, M21i, Tr, Ti);

% A12 = inv(M12);
% A11 = -A12*M11;
% A22 = M22*A12;
% A21 = M21-M22*A11;
% Ar   = [A11r,A12r;A21r,A22r];
% Ai   = [A11i,A12i;A21i,A22i];

% I = [      1,      0,       0,       0;
%            0,      1,       0,       0;
%            0,      0,       1,       0;
%            0,      0,       0,       1;];
% IC1 = [    0,      0,       0,       1;
%            1,      0,       0,       0;
%            0,      1,       0,       0;
%            0,      0,       1,       0;];
% IC2 = [    0,      1,       0,       0;
%            0,      0,       1,       0;
%            0,      0,       0,       1;
%            1,      0,       0,       0;];
% M11 =  (1/R1  +1i*w*C1)*I;
% M12 = -(1/R1*I+1i*w*C1*IC1);
% M21 =  (1/R1*I+1i*w*C1*IC2);
% M22 = -(1/R1  +1i*w*C1)*I;
% A12 = inv(M12);
% A11 = -A12*M11;
% A21 = M21-M22*A11;
% A22 = M22*A12;
% A11r=real(A11);
% A11i=imag(A11);
% A12r=real(A12);
% A12i=imag(A12);
% A21r=real(A21);
% A21i=imag(A21);
% A22r=real(A22);
% A22i=imag(A22);


function [invMr, invMi] = funCMinv(Mr, Mi)
MD    = inv(Mr)*Mi;
invMr = inv(Mr+Mi*MD);
invMi = -MD*invMr;

function [mutMr, mutMi] = funCMmut(M1r, M1i, M2r, M2i)
mutMr = M1r*M2r-M1i*M2i;
mutMi = M1r*M2i+M1i*M2r;

function [sumMr, sumMi] = funCMsum(M1r, M1i, M2r, M2i)
sumMr = M1r+M2r;
sumMi = M1i+M2i;

function [subMr, subMi] = funCMsub(M1r, M1i, M2r, M2i)
[subMr, subMi] = funCMsum(M1r, M1i, -M2r, -M2i);
              