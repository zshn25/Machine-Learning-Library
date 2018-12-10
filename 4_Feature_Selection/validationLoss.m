function Loss = validationLoss(Xtrain, Ytrain, Subsets)
% Exhaustive search of the best feature subset

if nargin <3
    Subsets = getsubsets();
end

[N,~]=size(Xtrain);
n_02 = round(0.2*N);

Loss = sparse(numel(Subsets),1);

for j=1:numel(Subsets)
    XtrainSubset = Xtrain(:,Subsets{j});  % Feature subset
%     XtestSubset = Xtest(:,Subsets{j});
    
    for i = 1:5 % 5-fold validation
        ivalid = logical(sparse((i-1)*n_02+1:i*n_02,1,1,N,1)); % validation index
        Xvalid = XtrainSubset(ivalid,:);
        Yvalid = Ytrain(ivalid);

        XNotvalid = XtrainSubset(~ivalid,:);
        YNotvalid = XtrainSubset(~ivalid);
    
        w = leastSquares(XNotvalid, YNotvalid);

        Loss(j) = Loss(j) + sum(0.5*abs(Yvalid - binarySign(Xvalid*w))) / nnz(ivalid);
    end
    Loss(j) = Loss(j) * 0.2;
end

end