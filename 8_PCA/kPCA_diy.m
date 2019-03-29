function [Y] = kPCA_diy(X, d, K0)
% Your implementation of kernel PCA
% Input:
%   X, input data, each row is a observation
%   d, reduced dimension
%   K, kernel
% Output:
%   Y, projected data on reduced dimension
if nargin < 3
    K0 = compute_gk(X);
end

N = size(X,1);
oneN=ones(N,N)/N;

% one has to center the data in the kernel feature space.
%http://www.face-rec.org/algorithms/Kernel/kernelPCA scholkopf.pdf
K=K0-oneN*K0-K0*oneN+oneN*K0*oneN;

% Solving the eigenproblem
[V,D]=eig(K);
[~,IX]=sort(D,'descend');
Vs=V(:,IX(1:d));

% Projection of the original points onto d principal components
Y = K*Vs;

end