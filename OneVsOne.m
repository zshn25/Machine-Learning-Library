clear; clc; close all;

load('USPSTrain.mat');
load('USPSTest.mat');

C = 100;

iter=1;
Fx_test = zeros(size(Xtest,1),1);
class0 = Ytrain == min(Ytrain);
Y1v1 = Ytrain(class0);
X1v1 = Xtrain(class0,:);

for class = min(Ytrain):max(Ytrain)
    % Remove the min class
    if class == min(Ytrain)
        continue;
    end
    Y = Ytrain;
    Y(class0) = -1;
    Y(Ytrain == class) = 1;
    Y = Y(class0 | Ytrain == class);
    X = Xtrain(class0 | Ytrain == class,:);
    
    sqdist = dist_euclidean(X,X).^2;
    gamma = median(sqdist(:));
    lambda = 3/gamma;
    k = gaussiankernel(X, lambda);
    
    [alpha{iter}(class0 | Ytrain == class), b{iter}(class0 | Ytrain == class)] = getKernelSVMSolution(k,Y,C);
    w{iter} = (alpha{iter}.*Y)'*X;
    
    
    
    % Test
    Fx_test_temp = dw{iter}*Xtest' + b{iter};
    Fx_test(Fx_test_temp == -1) = iter;
    
    iter=iter+1;
end

% Test
Fx_test*Ytest

randomimg=randi(size(Xtest,1))
VecToImage(Xtest(randomimg,:),16,16,0,2,0), title(Ytest(randomimg));

