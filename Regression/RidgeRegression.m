function w = RidgeRegression(DesignMatrix,Y, Lambda)
% RidgeRegression with CVX
% Inputs: DesignMatrix : n x D matrix, Y : nx1 vector
% Output: Weight vector w: Dx1 of least squares regression

[num,dim] = size(DesignMatrix);

% cvx_begin quiet
%       variable w(dim,1);
%       minimize(norm(Y-DesignMatrix*w, 2) + lambda*sum(w.^2));
% cvx_end

% Closed form solution: (p'p)^-1 p' Y
w = (DesignMatrix'*DesignMatrix + Lambda * ones(dim)) \ (DesignMatrix' * Y);

end

