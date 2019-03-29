function [Y] = PCA_diy(X, d)
% Implementation of PCA
% Input:
%   X, input data, each row is a observation
%   d, reduced dimension
% Output:
%   Y, projected data on reduced dimension

% eigen decomposition of covariance matrix
[V,D] = eig(cov(X));

% sort the variances in descreasing order
[~,IX] = sort(D,'descend');
V_s = V(:,IX);

% project to lower dimensions
V_s = V_s(:,1:d);
Y = X*V_s;

end