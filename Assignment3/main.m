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
% sizek = numel(ks);
% D = 2*sizek+1;
plot(Xtrain,Ytrain,'b.'); hold on;

for k = ks
    
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

%% Question 7 d)
clear; close all; clc;
load('Part2-TrainingData.mat');
n = size(Xtrain,1);
% Add the bias feature (1)
Xtrain = [Xtrain, ones(n,1)];
% DesignMatrix = Basis(Xtrain, 
% X has many features which act as basis
w = LeastSquares(Xtrain, Ytrain);
err = Ytrain - Xtrain * w;
trainloss = dot(err, err) ./ n;
save LossSecondEx trainloss;

%% Prediction2
clear;
load('Part2-TrainingData.mat');
% Allocate validation data
Xvalidation = Xtrain(end-49:end,:);
Yvalidation = Ytrain(end-49:end,:);

Xtrain = Xtrain(1:end-50,:);
Ytrain = Ytrain(1:end-50,:);
[N, D] = size(Xtrain);
% Training with Lasso Regression with polynomial basis
Lambda = 0.1;
basis = [0,1,2,3];

% Basis functions: Polynomial: [1 x, x^2, x^3]
% DesignMatrix = [ones(N,1), Xtrain, Xtrain.^2, Xtrain.^3];
for b = basis
    if b == 0
        DesignMatrix = [DesignMatrix, ones(N,1)];
        continue;
    end
    DesignMatrix = [DesignMatrix, X.^b];
end
% Decided to use Lasso Regression for tion of useful features only
w = LassoRegression(DesignMatrix, Ytrain, Lambda);

f = Prediction2(Xtrain, w, basis);

% Calculate loss
err = Ytrain - f;
trainloss = dot(err, err) ./ N;
err_validation = Yvalidation - Prediction2(Xvalidation, w, basis);
validationloss = dot(err_validation, err_validation) ./ size(Xvalidation,1);
