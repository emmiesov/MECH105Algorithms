function [L, U, P] = luFactor(A)
% luFactor(A)
%	LU decomposition with pivotiing
% inputs:
%	A = coefficient matrix
% outputs:
%	L = lower triangular matrix
%	U = upper triangular matrix
%   P = the permutation matrix

% Size of Matrix & Seeing if it is a square
[m,n] = size(A);
if m~=n
    error('need square matrix')
end

% Matrices
L = eye( size(A) );
U = A;
P = eye( size(A) );

% Switching rows
for i=1:n-1
    % Finds which row in column one has the largest value
    [~,maxVal] = max( abs( U(1:n,i) ) );
    if i~=maxVal
        % Pivoting for Upper Triangular Matrix
        u_row_temp = U(i,:)
        U(i,:) = U(maxVal,1:n)
        U(maxVal,:) = u_row_temp
        % Pivoting for Pivot Matrix
        p_row_temp = P(i,:)
        P(i,:) = P(maxVal,1:n)
        P(maxVal,:) = p_row_temp
    end
end

% Forward Elimination
for i = 1:n
    pivotElement = U(i,i)
    for index = i+1:n
        scalar = U(index,i)/pivotElement
        U(index,1:n) = U(index,1:n) - scalar*U(i,1:n)
        L(index,i) = scalar
    end
end

% Backwards Substitution