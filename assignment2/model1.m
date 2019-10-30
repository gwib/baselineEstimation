function [estHeight] = model1(X,Y,estCoeff)
estHeight = estCoeff(1)*X^2+estCoeff(2)*X*Y+estCoeff(3)*Y^2+estCoeff(4)*X ...
    + estCoeff(5)*Y + estCoeff(6);
end
