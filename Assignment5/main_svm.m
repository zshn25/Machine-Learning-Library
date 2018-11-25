clear; close all; clc;
load('DIGITS01.mat');
C = [10,100,200,500];

for c = C
    [alpha, w, TrainErrs, TestErrs] = CoordinateDescentSVM(Xtrain, ytrain, c, Xtest, ytest);
    plot(1:numel(TrainErrs),TrainErrs,'b:');
    saveas(gcf, ['DIGITS01TrainErrs_' num2str(c)], 'png');
    plot(1:numel(TrainErrs),TestErrs,'g.-');
    saveas(gcf, ['DIGITS01TestErrs_' num2str(c)], 'png');
end