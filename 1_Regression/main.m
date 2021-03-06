% Regression using Fourier Basis functions and L1 loss
close all; clear; clc;
%% Load data
load('Part1-TrainingData.mat')
load('Part1-TestData.mat')
x = 0:0.01:1;
Lambda = 0.0001;
ks = [1,2,3,5,10,15,20];
loss = zeros(numel(ks),1);

n = numel(Xtrain);
Colors = jet(numel(ks));
% sizek = numel(ks);
% D = 2*sizek+1;
plot(Xtrain,Ytrain,'b.'); hold on;

for k = ks
    
    DesignMatrix = Basis(Xtrain,k);  % size = n x D
    % ToDo: Choose which regression to use here
    wk = Lasso(Ytrain, DesignMatrix, Lambda); % size = Dx1
    % Prediction
    fk = DesignMatrix * wk;
    % Loss (Least squares loss for Ridge regression)
    err_train = Ytrain - fk;
    trainloss(ks==k) = dot(err_train, err_train)./n;
    % Repeat same for test data
    fk_test = Basis(Xtest,k) * Lasso(Ytest, DesignMatrix, Lambda);
    err_test = Ytest - fk_test;
    testloss(ks==k) = dot(err_test, err_test)./n;
    
    % Plot
    p2 = plot(Xtrain, fk, '.', 'color', Colors(ks==k,:));
    legend('Y', ['f(x) for k = ' num2str(k)])
    saveas(gcf, ['PlotFunctions' num2str(k)], 'png');
    set(p2,'Visible','off');
end

%% Plot the training and test loss
figure('Name','Loss Plot'), 
plot(ks, trainloss, 'go-', ks, testloss, 'bo-');
title('Loss Plot'), xlabel('k'), ylabel('Loss');
legend('Train Loss', 'Test Loss');
saveas(gcf, 'PlotLoss', 'png');
save LossFirstEx trainloss testloss;

%% Question 7 d)
