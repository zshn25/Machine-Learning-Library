% Script
load('auc')

% 
randomY1 = randi([0, 1], size(Y1,1), 1000) * 2 - 1;
randomY2 = randi([0, 1], size(Y2,1), 1000) * 2 - 1;


bla=PlotROC(Y1, randomY1)

figure,plot(bla)

bla1=PlotROC(Y2, randomY2)

figure,plot(bla1)