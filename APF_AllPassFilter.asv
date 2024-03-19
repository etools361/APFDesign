%--------------------------------------------------------------------------
% Edited by bbl
% Date: 2024-03-17(yyyy-mm-dd)
% all pass filter for testing only
%--------------------------------------------------------------------------
Fl = 270;
Fh = 3600;
n  = 6;
R  = 12e3*ones(1,n);
N = 100;
[fx1] = funPolyPhaseNetwork(Fl, Fh, n);
C = 1./(2.*pi.*R.*fx1);
ft = logspace(floor(log10(Fl)), ceil(log10(Fh)), N);
RL = 1e6;
[ang, Suppression] = funAnaPN(R, C, RL, ft);
semilogx(ft, ang*180/pi, '-m', 'Linewidth', 2);
ylim([-0.5,0.5]+90);
grid on;
hold on;
semilogx(ft, real(Suppression), '--g', 'Linewidth', 2);
hold off;
grid on;
ylim([20,100]);


n = 3;
[fx2] = funAllPassFilter(Fl, Fh, n*2);
C = 10e-9*ones(1,2*n);
R = 1./(2.*pi.*C.*fx2);
[ang, Suppression] = funAnaOP(R, C, ft);
hold on;
semilogx(ft, abs(ang)*180/pi);
semilogx(ft, real(Suppression), '--b', 'Linewidth', 2);
hold off;
grid on;
ylim([30,100]);


n = 6;
k = Fl/Fh;
lambda = ellipdeg(n, k);
[K,Kp]   = ellipk(k);
a_bar    = zeros(1, n);
for ii=1:n
    a_bar(ii) = 1i.*Fl*sne(1i*(1+4*(ii-1))/(2*n)*Kp/K, k);
%     fprintf('a_bar(%d) = %0.5f j\n', ii, imag(a_bar(ii)));
end
fx3 = a_bar


