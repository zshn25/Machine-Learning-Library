function w=L1LossPlusL2Regularization(Phi,Y,lambda)
% computes the weight vector w of L1 Loss + L2 regularization in w
% given:
% Phi: design matrix
% Y: outputs
% lambda: regularization parameter

[num,dim] = size(Phi);

cvx_begin quiet
      variable w(dim,1);
      minimize(norm(Y-Phi*w,1)+lambda*sum(w.^2));
cvx_end


