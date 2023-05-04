function [I] = Simpson(x, y)
% Numerical evaluation of integral by Simpson's 1/3 Rule
% Inputs
%   x = the vector of equally spaced independent variable
%   y = the vector of function values with respect to x
% Outputs:
%   I = the numerical integral calculated

% If arrays match sizes
xLength = length(x);
yLength = length(y);
if xLength ~= yLength % && yLength ~= xLength
    error('Error. Inputs need to be the same size.')
end

% If xs are equally spaced
xSpacing = isuniform(x);
if xSpacing ~= 1
    error('Error. X inputs must be equally spaced.')
end

% Number of Points in data
pointsTotal = xLength;
% Number of Segments in data
n = pointsTotal-1;

nOdd = mod(n,2);
if nOdd ~= 0
    warning('Uneven number of segments. Trapezoidal Rule will be used on last interval.')
    a = x(1);
    b = x(end-1);
    h = b-a;
    n = n-1; 
    I = (h/(3*n))*(y(1)+4*sum( y(2:2:n) )+2*sum( y(3:2:n) )+y(end-1));
    % Last interval starting at end-1 to end
    ITrap = (x(end)-x(end-1))*((y(end-1) + y(end))/2);
    I = I + ITrap;
else
    % composite simpson's rule
    a = x(1);
    b = x(end);
    h = b-a;
    I = (h/(3*n))*(y(1)+4*sum( y(2:2:end-1) )+2*sum( y(3:2:end) )+y(end));
end


% Composite Simpson's 1/3 Rule
I = ((b-a)/(3*n))*((y(1)+4*sum(y(2:2:pointsTotal-1))+2*sum(y(3:2:pointsTotal-1))+y(end)));


end