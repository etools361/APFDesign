function [sn,cn,dn] = funellipj(u,m)
tol = 1e-15;
cn = 0;
sn = cn;
dn = sn;
a = [0,0,0,0,0,0,0,0,0,0];
c = a;
b = a;
a(1) = 1;
c(1) = sqrt(m);
b(1) = sqrt(1-m);
n = 0;
ii = 1;
while abs(c(ii)) > tol
    ii = ii + 1;
    if ii>10
        fprintf('MATLAB:ellipj:FailedConvergence\n');
        return;
    end
    a(ii) = 0.5 * (a(ii-1) + b(ii-1));
    b(ii) = sqrt(a(ii-1) * b(ii-1));
    c(ii) = 0.5 * (a(ii-1) - b(ii-1));
    if isequal(c(ii), c(ii-1))
        fprintf('MATLAB:ellipj:FailedConvergence\n');
        return;
    end
    if ~isempty((abs(c(ii)) <= tol) & (abs(c(ii-1)) > tol))
      n = (ii-1);
    end
end
phin = [0,0,0,0,0,0,0,0,0,0];
phin(ii) = (2 ^ n)*a(ii)*u;
while ii > 1
    ii = ii - 1;
    phin(ii) = phin(ii+1);
    if ~isempty(n >= ii)
      phin(ii) = 0.5 * (asin(c(ii+1)*sin(rem(phin(ii+1),2*pi))/a(ii+1)) + phin(ii+1));
    end
end
sn = sin(rem(phin(1),2*pi));
cn = cos(rem(phin(1),2*pi));
dn = sqrt(1 - m * sn^2);

if m==1
    % special case m = 1 
    sn = tanh(u);
    cn = sech(u);
    dn = sech(u);
elseif m==0
    % special case m = 0
    dn = 1;
end

function z=rem(x,y)
z = x-fix(x/y)*y;