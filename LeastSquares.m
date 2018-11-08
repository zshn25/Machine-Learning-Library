function w = LeastSquares(DesignMatrix,Y)
%LEASTSQUARES with CVX
% Inputs: DesignMatrix : n x D matrix, Y : n vector
% Output: Weight vector w of least squares regression

[num,dim] = size(Phi);

% cvx_begin quiet
%       variable w(dim,1);
%       minimize(norm(Y-DesignMatrix*w, 2));
% cvx_end

% Closed form solution: (p'p)^-1 p' Y
w = (DesignMatrix'*DesignMatrix) \ (DesignMatrix' * Y);

end

