close all; clear; clc;
%% Cross Validation in Feature Selection
load('DataFeatSel1.mat')
[N,D]=size(Xtrain);
n_02 = round(0.2*N);
Subsets = getsubsets();
% Loss = sparse(numel(Subsets),1);

Loss = validationLoss(Xtrain, Ytrain, Subsets);

[minErr,minIdx] = min(Loss);

bestFeatureSubset = Subsets{minIdx} % is the best subset

% Test error for best feature subset
wtest = leastSquares(Xtest(:,bestFeatureSubset), Ytest);
TestErr = sum(0.5*abs(Ytest - binarySign(Xtest(:,bestFeatureSubset)*wtest))) / size(Xtest,1)

%% Permutation test
% Best feature among first 6 features
close all; clear; clc;
load('DataFeatSel1.mat')
[N,D]=size(Xtrain);

BinCodes = allsets(6);
numbers=1:6;
for i=2:size(BinCodes,1)
    Subsets{i-1}=numbers(BinCodes(i,:)==1);
end
Loss = validationLoss(Xtrain(:,1:6), Ytrain, Subsets);

[minErr,minIdx] = min(Loss);
bestFeatureSubset = Subsets{minIdx} % is the best subset
% wtest = leastSquares(Xtest(:,bestFeatureSubset), Ytest);
% 
% Ymodel = binarySign(Xtest(:,bestFeatureSubset)*wtest);
% Random permutation
alpha = 0.05;
rand('state',1);
for i = 1 : 1000
    randY(:,i) = Ytrain(randperm(N));
    randLoss(i) = validationLoss(Xtrain, randY(:,i), {bestFeatureSubset});
    
end

% z = (randLoss -  minErr) / std(randLoss');

nnz(randLoss < 0.4) / 1000

bestFeatureSubset = Subsets{minIdx} % is the best subset

hist(randLoss,20)




