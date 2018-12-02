function k = gaussiankernel(X, lambda)
% Returns the positive semi-definite gaussian kernel
% Inputs: X: m x n matrix of training data

if nargin < 2
    sqdist = dist_euclidean(X,X).^2;
    gamma = median(sqdist(:));
    lambda = 3/gamma;
end
k = exp(-lambda*dist_euclidean(X,X));


end