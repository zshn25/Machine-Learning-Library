clear;
load('Part2-TrainingData.mat');
% Allocate validation data
% Xvalidation = Xtrain(end-49:end,:);
% Yvalidation = Ytrain(end-49:end,:);
% 
% Xtrain = Xtrain(1:end-50,:);
% Ytrain = Ytrain(1:end-50,:);
% 
% % Normalize training data
% Xtrain = (Xtrain - mean(Xtrain,1)) ./ std(Xtrain,1);
% Ytrain = (Ytrain - mean(Ytrain,1)) ./ std(Ytrain,1);


[N, D] = size(Xtrain);
% Training with Lasso Regression with polynomial basis
Lambda = 0.001;
% basis = [0,1,2,3];

% Basis functions: Polynomial: [1 x, x^2, x^3]
% DesignMatrix = [ones(N,1), Xtrain, Xtrain.^2, Xtrain.^3];
% DesignMatrix = [];
% for b = basis
%     if b == 0
%         DesignMatrix = [DesignMatrix, ones(N,1)];
%         continue;
%     end
%     DesignMatrix = [DesignMatrix, Xtrain.^b];
% end
DesignMatrix = [ones(N,1), Xtrain];
% Decided to use Lasso Regression for tion of useful features only
w = Lasso(Ytrain, DesignMatrix, Lambda);

f = DesignMatrix * w;

% Calculate loss
err = Ytrain - f;
trainloss = dot(err, err) ./ N;
% err_validation = Yvalidation - Prediction2(Xvalidation, w, basis);
% validationloss = dot(err_validation, err_validation) ./ size(Xvalidation,1);
