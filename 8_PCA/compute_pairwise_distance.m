function D = compute_pairwise_distance( X, Y )
% compute the pairwise distance (L2) between x1,x2
%   x1,x2: size NxD, N is the number of data and D is the dimension of each
%   data point

    m = size(X,1); n = size(Y,1);  
    Yt = Y';  
    XX = sum(X.*X,2);        
    YY = sum(Yt.*Yt,1);      
    D = XX(:,ones(1,n)) + YY(ones(1,m),:) - 2*X*Yt;
    
%     Faster than the one below
%     D = bsxfun(@plus,dot(x1,x1,2),dot(x2,x2,2)')-2*(x1*x2');
end