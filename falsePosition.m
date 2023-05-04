function [root, fx, ea, iter] = falsePosition(func, xl, xu, es, maxit, varargin)
% falsePosition finds the root of a function using false position method. Potentially a while or a nested for loop because of interations.
% False Position creates a secant line with where xl and xu are on the function's curve. Where this line intersects the x-axis is the location of the root.
% The secant line with xl and xu creates 2 triangles, potentially on either side of the x-axis, resulting in similiar triangles formulas. 
% Equation: xr = xu - f(xu)*(xl-xu)/f(xl)-f(xu); xr replaces either xl or xu if f(xl) or f(xu) has the same sign as f(xr).
% Inputs:
%   func: anonymous function given by insert
%   xl: lower bound (xr replaces xl depending on nth iteration)
%   xu: upper bound (xr replaces xu depending on nth iteration)
%   es: stopping criteria (default of 0.0001%). When root < es, the function terminates
%   maxit: number of iterations needed (default of 200). Potentially an array from 1:nth with default of 1:200
%   varargin=additional parameters used by functions
% Outputs:
%   root: estimated location
%   fx: function evaluated at root location. Need to save the previous fx to compare it to current fx? 
%   ea: approximate relative error (%): abs((new-old)/new)*100
%   iter: number of iterations performed out of number of iterations wanted, so display this number (fprintf) 

% Ready, set, go false position
ea = 100;
iter = 0;
xr = xl;

if nargin > 6
    vargargin = varargin;
        while ea > es
            iter = iter + 1;
            % xr is somewhere from the lower to upper bound
            rootPrev = xr;
            % function evaluated at lower and upper bounds
            fxl = func(xl, varargin);
            fxu = func(xu, varargin);
            % root guess and root at function using the false position formula
            xr = xu - ((fxu).*(xl - xu))./((fxl)-(fxu));
            fx = func(xr);
            % if xr replaces xl or xu
                if (fxl*fx) > 0
                    xl = xr;
                else
                    xu = xr;
                end
            % Estimation of Error
            % Save my xr then go repeat the fpt process then find Ea
            root = xr;
            ea = abs( (root - rootPrev) ./ root ) .* 100;
        end
 elseif nargin > 5
    maxit = 200;
        while ea > es
            iter = maxit - (maxit - 1);
            % xr is somewhere from the lower to upper bound
            rootPrev = xr;
            % function evaluated at lower and upper bounds
            fxl = func(xl);
            fxu = func(xu);
            % root guess and root at function using the false position formula
            xr = xu - ((fxu).*(xl - xu))./((fxl)-(fxu));
            fx = func(xr);
            % if xr replaces xl or xu
                if (fxl*fx) > 0
                    xl = xr;
                else
                    xu = xr;
                end
            % Estimation of Error
            % Save my xr then go repeat the fpt process then find Ea
            root = xr;
            ea = abs( (root - rootPrev) ./ root ) .* 100;
        end
elseif nargin < 4
    es = 0.0001;
    maxit = 200;
        while ea > es
            iter = maxit - (maxit - 1);
            % xr is somewhere from the lower to upper bound
            rootPrev = xr;
            % function evaluated at lower and upper bounds
            fxl = func(xl);
            fxu = func(xu);
            % root guess and root at function using the false position formula
            xr = xu - ((fxu).*(xl - xu))./((fxl)-(fxu));
            fx = func(xr);
            % if xr replaces xl or xu
                if (fxl*fx) > 0
                    xl = xr;
                else
                    xu = xr;
                end
            % Estimation of Error
            % Save my xr then go repeat the fpt process then find Ea
            root = xr;
            ea = abs( (root - rootPrev) ./ root ) .* 100;
        end
else
    error('Error. Funcion needs a minimum of 3 arguments.');
end

fprintf('The estimated root of the function is %f\n.', root)
fprintf('The value of the function evaluated at the estimated root is %f\n.', fx)
fprintf('The estimated error of the root is %f\n.', ea);
fprintf('The number of iterations taken to find the root is %f\n.', iter)


% false position formula: xr = ux - ( fxu .* (xl - xu) ) ./ (fxl - fxu) );

% f = x.^3
% xl = -1
% xu = 1
% fxl = xl.^3
% fxu = xu.^3
% xr = xu - ( ( fxu .* (xl - xu) ) ./ ( fxl - fxu ) )
% fxr = xr.^3

% if sign < 0 then xu = xr
% if sign > 0 then xl = xr

% while falsePosition est < es then end loop and display output values

% for 1:iterations
% boundDifference = xu - xl
% stoppingCriteria = es
% iterTotal = log2(boundDifference/stoppingCriteria)

end
