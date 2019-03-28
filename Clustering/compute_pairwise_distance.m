function D = compute_pairwise_distance( X, Y )
% compute the pairwise distance (L2) between x1,x2
%   x1,x2: size NxD, N is the number of data and D is the dimension of each
%   data point
    if( ~isa(X,'double') || ~isa(Y,'double'))
        error( 'Inputs must be of type double'); 
    end
    
    m = size(X,1); n = size(Y,1);  
    Yt = Y';  
    XX = sum(X.*X,2);        
    YY = sum(Yt.*Yt,1);      
    D = XX(:,ones(1,n)) + YY(ones(1,m),:) - 2*X*Yt;
end