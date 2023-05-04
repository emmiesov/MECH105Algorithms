function [fX, fY, slope, intercept, Rsquared] = linearRegression(x,y)
%linearRegression Computes the linear regression of a data set
%   Compute the linear regression based on inputs:
%     1. x: x-values for our data set
%     2. y: y-values for our data set
%
%   Outputs:
%     1. fX: x-values with outliers removed
%     2. fY: y-values with outliers removed
%     3. slope: slope from the linear regression y=mx+b
%     4. intercept: intercept from the linear regression y=mx+b
%     5. Rsquared: R^2, a.k.a. coefficient of determination

%Prerequisite
    xLength = length(x);
    yLength = length(y);
    if xLength < yLength || yLength < xLength
        error('Error. Inputs must be same size.\n')
    end

%STEP ONE: FILTER OUTLIERS FROM DATASET
% Sorting x values and corresponding y values
    [sortedY, sortOrder] = sort(y);
    sortedX = x(sortOrder)
% Q1 and Q3 Indices
    Q1index = floor( (length(sortedX)+1) / 4 );
    Q3index = floor( (3*length(sortedX)+3) / 4 );
% Y values that correspond with Q1 and Q3 indices
    Q1 = sortedY(Q1index);
    Q3 = sortedY(Q3index);
% Interquartile Range
    IQR = Q3 - Q1;
% What are the outliars?
    lowerBound = Q1 - (IQR*1.5);
    upperBound = Q3 + (IQR*1.5);

    sortedY = sortedY(lowerBound <= sortedY & sortedY <= upperBound);
    fY = sortedY;
    sortedX = sortedX(1:length(fY));
    fX = sortedX;

%STEP TWO: LINEAR REGRESSION LINE FOR FILTERED DATASET
% Use filtered data set to find linear regression equation
% Means of filtered x and y datasets
    fYmean = sum(fY)/length(fY);    
    fXmean = sum(fX)/length(fX);
% Normal Equations
    n = length(fX);
    xSum = sum(fX);
    ySum = sum(fY);
    xySum = sum( (fX.*fY) );
    xSumSquared = sum( (fX.^2) );
    
    a1 = ( (n*xySum) - (xSum*ySum) ) / ( (n*xSumSquared) - (xSum.^2) );
    a0 = fYmean - a1*fXmean;
% Linear Regression
    slope = a1;
    intercept = a0;
    yLR = intercept + slope.*fX;
% Total Sum of Squared
    SStot = sum( (fY - fYmean).^2 );
% Sum of Squares of Residuals
    SSres = sum( (fY - a0 - a1.*fX).^2 );

%STEP THREE: R^2 VALUE FROM FILTERED DATASET & LINEAR REGRESSION FUNCTION
%   R^2 coefficient of determination
    Rsquared = (SStot - SSres)/SStot;

end
