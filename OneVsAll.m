clear; clc; close all;

load('USPSTrain.mat');
load('USPSTest.mat');

sqdist = dist_euclidean(Xtrain,Xtrain).^2;
gamma = median(sqdist(:));
lambda = 3/gamma;
C = 100;

k = gaussiankernel(Xtrain, lambda);

iter=1;
Fx_test = zeros(size(Xtest,1),1);
for class = min(Ytrain):max(Ytrain)
    
    Y = Ytrain;
    Y(Ytrain==class) = -1;
    Y(~(Ytrain==class)) = 1;
    [alpha{iter}, b{iter}] = getKernelSVMSolution(k,Y,C);
    w{iter} = (alpha{iter}.*Y)'*Xtrain;
    
    
    
    % Test
    Fx_test_temp = w{iter}*Xtest' + b{iter};
    Fx_test(Fx_test_temp == -1) = iter;
    
    iter=iter+1;
end

% Test
Fx_test*Ytest

randomimg=randi(size(Xtest,1))
VecToImage(Xtest(randomimg,:),16,16,0,2,0), title(Ytest(randomimg));

