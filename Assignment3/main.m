close all; clear; clc;
load('Part1-TrainingData.mat')
x = 0:0.01:1;
n = numel(Xtrain);
Lambda = 10;
ks = [1,2,3,5,10,15,20];
sizek = numel(ks);
plot(Xtrain,Ytrain,'b.'); hold on;
% w = zeros(D,sizek);
% f = dot(zeros(n,D), w(:,1));
loss = zeros(numel(ks),1);
for k = ks
    
    D = 2*sizek+1;
    DesignMatrix = Basis(Xtrain,k);  % size = n x D
    % ToDo: Choose which regression to use here
    wk = RidgeRegression(DesignMatrix, Ytrain, Lambda); % size = Dx1
    % Prediction
    fk = DesignMatrix * wk;
    % Loss
    
    
    % Plot
    p2 = plot(Xtrain, fk, 'g.');
    saveas(gcf, 'PlotFunctions', 'png');
    legend('Y', ['f(x) for k = ' num2str(k)])
    delete p2;
end