function w = LassoRegression_cvx(Y, DesignMatrix, Lambda)
% LassoRegression with CVX
% Inputs: DesignMatrix : n x D matrix, Y : nx1 vector
% Output: Weight vector w: Dx1 of least squares regression

cvx_begin quiet
      variable w(d,1);
      minimize(norm(Y-DesignMatrix*w, 2) + Lambda*sum(abs(w)));
cvx_end

end

