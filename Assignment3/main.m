close all; clear; clc;
%% Load data
load('Part1-TrainingData.mat')
load('Part1-TestData.mat')
x = 0:0.01:1;
Lambda = 10;
ks = [1,2,3,5,10,15,20];
loss = zeros(numel(ks),1);

n = numel(Xtrain);
Colors = jet(numel(ks));
sizek = numel(ks);
plot(Xtrain,Ytrain,'b.'); hold on;

for k = ks
    
    D = 2*sizek+1;
    DesignMatrix = Basis(Xtrain,k);  % size = n x D
    % ToDo: Choose which regression to use here
    wk = RidgeRegression(DesignMatrix, Ytrain, Lambda); % size = Dx1
    % Prediction
    fk = DesignMatrix * wk;
    % Loss (Least squares loss for Ridge regression)
    err_train = Ytrain - fk;
    trainloss(ks==k) = dot(err_train, err_train)./n;
    err_test = Ytest - fk;
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

