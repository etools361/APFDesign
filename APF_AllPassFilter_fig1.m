%--------------------------------------------------------------------------
% Edited by bbl
% Date: 2024-03-17(yyyy-mm-dd)
% all pass filter for testing only
%--------------------------------------------------------------------------
Fl = 500;
Fld = 1;
Fh = 10000;
Fhd = 1e4;
n  = 8;
R  = 12e3*ones(1,n);
N = 100;
[fx1] = funPolyPhaseNetwork(Fl, Fh, n);
C = 1./(2.*pi.*R.*fx1);
ft = logspace(floor(log10(Fld)), ceil(log10(Fhd)), N);
RL = 1e6;
[ang, Suppression] = funAnaPN(R, C, RL, ft);
% k = 10;
% % Pz = ft.*(2.*pi.*R(1)*C(1));
% % P=(1+1i.*Pz);
% Pz = [];
% for ii=1:n
%     Pz(ii,:) = ft.*(2.*pi.*R(ii)*C(ii));
% %     P = P.*(-1+1i.*Pz);
% end
% Prn = 1+Pz(1,:).*Pz(2,:)+Pz(2,:).*Pz(3,:)+Pz(1,:).*Pz(3,:)+Pz(1,:).*Pz(2,:).*Pz(3,:);
% Pin = Pz(1,:)+Pz(2,:)+Pz(3,:);
% ang = angle(-(Prn+1i.*Pin)./(-Prn+1i.*Pin));
[ang, Suppression] = funAnaPN2(R, C, RL, ft);
plot(ft, ang*180/pi, '-b', 'Linewidth', 2);
% ylim([-0.5,0.5]+90);
grid on;
hold on;
% semilogx(ft, real(Suppression), '-g', 'Linewidth', 2);
plot(ft, ft*180.*0.66e-4, '-r', 'Linewidth', 2);
hold off;
grid on;
ylim([0,120]);

set(gcf, 'color', [1,1,1]);
xlabel('Freq/Hz');
ylabel('Phase/degree');
legend({'TLIN', '90° Phase-Shift Network'}, 'location', 'southeast')
% n = 5;
% [fx2] = funAllPassFilter(Fl, Fh, n*2);
% C = 10e-9*ones(1,2*n);
% R = 1./(2.*pi.*C.*fx2);
% [ang, Suppression] = funAnaOP(R, C, ft);
% hold on;
% semilogx(ft, abs(ang)*180/pi, '--g');
% semilogx(ft, real(Suppression), '--b', 'Linewidth', 2);
% hold off;
% grid on;
% ylim([30,100]);


% n = 1;
% k = Fl/Fh;
% lambda = ellipdeg(n, k);
% [K,Kp]   = ellipk(k);
% a_bar    = zeros(1, n);
% for ii=1:n
%     a_bar(ii) = 1i.*Fl*sne(1i*(1+4*(ii-1))/(2*n)*Kp/K, k);
% %     fprintf('a_bar(%d) = %0.5f j\n', ii, imag(a_bar(ii)));
% end
% fx3 = a_bar
% 
% [sn,cn,dn] = funellipj(0.5,0.9)
% [sn,cn,dn] = ellipj(0.5,0.9)


