%--------------------------------------------------------------------------
% Edited by bbl
% Date: 2022-08-30(yyyy-mm-dd)
% 实际器件
%--------------------------------------------------------------------------
function [iType, Value] = funSynthesisFilterActual(iType, Value, strNL, strNC)
[nL, EnL] = funGetEn(strNL);
[nC, EnC] = funGetEn(strNC);
nNetlist    = length(iType);
for ii = 1:nNetlist
    % 0:V,1:I,2:R,3:L,4:C
    iTypec = iType(ii);
    if iTypec == 0 % V
        Value(ii) = Value(ii);
    elseif iTypec == 1 % I
        Value(ii) = Value(ii);
    elseif iTypec == 2 % R
        Value(ii) = Value(ii);
    elseif iTypec == 3 % L
        if nL
            Value(ii) = Ideal2ActualValue(Value(ii), nL, EnL);
        end
    elseif iTypec == 4 % C
        if nC
            Value(ii) = Ideal2ActualValue(Value(ii), nC, EnC);
        end
    end
end




