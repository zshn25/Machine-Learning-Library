function [K] = compute_gk(X)
% compute gaussian kernel
D = compute_pairwise_distance(X,X);
% D = bsxfun(@plus,dot(X,X,2),dot(X,X,2)')-2*(X*X');
D_ = D;
D_(D==0)=inf;
D_ = min(D_);
sigma = mean(D_);
K=exp(-D./(2*sigma.^2));
end