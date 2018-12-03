clear; clc; close all;

load('USPSTrain.mat');
load('USPSTest.mat');

C = 100;

iter=1;
Fx_train = zeros(size(Xtrain,1),10)*NaN;
Fx_test = zeros(size(Xtest,1),10)*NaN;
class0 = Ytrain == min(Ytrain);
Y1v1 = Ytrain(class0);
X1v1 = Xtrain(class0,:);

for class = min(Ytrain):max(Ytrain)
    % Remove the min class
    if class == min(Ytrain)
        iter=iter+1;
        continue;
    end
    Y = Ytrain;
    Y(class0) = -1;
    Y(Ytrain == class) = 1;
    Y = Y(class0 | Ytrain == class);
    X = Xtrain(class0 | Ytrain == class,:);
    
    sqdist = dist_euclidean(X,X);
    gamma = median(sqdist(:));
    lambda = 3/gamma;
    k = gaussiankernel(X, lambda);
    
    [alpha{iter}(class0 | Ytrain == class), b{iter}] = getKernelSVMSolution(k,Y,C);
    w{iter} = (alpha{iter}(class0 | Ytrain == class).*Y')*X;
    
    % Train
    Fx_train_temp = w{iter}*Xtrain' + b{iter};
%     Fx_train(Fx_train_temp < 0,iter) = min(Ytrain);
    Fx_train(Fx_train_temp > 0,iter) = class;
    
    % Test
    Fx_test_temp = w{iter}*Xtest' + b{iter};
%     Fx_test(Fx_test_temp < 0, iter) = min(Ytrain);
    Fx_test(Fx_test_temp > 0, iter) = class;
    
    iter=iter+1;
end
Fx_train = tsnanmode(Fx_train,2);
Fx_test = tsnanmode(Fx_test,2);
% Train 
correct_classification_train = sum(Fx_train == Ytrain) / size(Ytrain,1)

% Test
correct_classification_test = sum(Fx_test == Ytest) / size(Ytest,1)

plotvec = Xtest(Fx_test ~= Ytest,:);
plotvec_y = Ytest(Fx_test ~= Ytest,:);
plotvec_fx = Fx_test(Fx_test ~= Ytest,:);
% randomimg=randi(size(Xtest,1));
vec2img=VecToImage(plotvec(1:100,:),16,16,0,2,1);
for i=1:100
    subplot(vec2img(i)), title(['True: ', num2str(plotvec_y(i)), ' - Pred: ', num2str(plotvec_fx(i))]);
end


save PredOneVersusOne Fx_test;