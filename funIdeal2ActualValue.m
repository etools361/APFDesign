%--------------------------------------------------------------------------
% Edited by bbl
% Date: 2022-08-30(yyyy-mm-dd)
% 实际器件
%--------------------------------------------------------------------------
function R = funIdeal2ActualValue(R, n, En)
mUnitR  = log10(R);
iUR     = floor(mUnitR);
mUR     = 10^iUR;
mm      = R/mUR;
mmax    = 10^((n-1)/n);
if mm<1
    mm = 1;
elseif mm>mmax
    mm = mmax;
end
emm     = round(n*log10(mm))+1;
R = En(emm)*mUR;