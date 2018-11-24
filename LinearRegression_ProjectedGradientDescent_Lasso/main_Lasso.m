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

% Normalize training data
Xtrain = (Xtrain - mean(Xtrain,1)) ./ std(Xtrain,1);
Ytrain = (Ytrain - mean(Ytrain,1)) ./ std(Ytrain,1);


[N, D] = size(Xtrain);
% Training with Lasso Regression with polynomial basis
Lambda = 0.001;
basis = [0,1,2,3];

% Basis functions: Polynomial: [1 x, x^2, x^3]
% DesignMatrix = [ones(N,1), Xtrain, Xtrain.^2, Xtrain.^3];
DesignMatrix = [];
for b = basis
    if b == 0
        DesignMatrix = [DesignMatrix, ones(N,1)];
        continue;
    end
    DesignMatrix = [DesignMatrix, Xtrain.^b];
end
% Decided to use Lasso Regression for tion of useful features only
w = LassoRegression_cvx(Ytrain, DesignMatrix, Lambda);  %cvx package
w = Lasso(Ytrain, DesignMatrix, Lambda);    % projected gradient descent
f = Prediction2(Xtrain, w, basis);

%% Calculate loss
err = Ytrain - f;
trainloss = dot(err, err) ./ N;
err_validation = Yvalidation - Prediction2(Xvalidation, w, basis);
validationloss = dot(err_validation, err_validation) ./ size(Xvalidation,1);
%%


