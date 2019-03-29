% Script for testing your PCA & kPCA code
clear;clc;close all;

load('pca_data.mat');
d = 2;

% plot original data
figure;hold on;
plot3(data(1:2:end,1),data(1:2:end,2),data(1:2:end,3),'b*');
plot3(data(2:2:end,1),data(2:2:end,2),data(2:2:end,3),'ro');
legend('class 1','class 2');
axis equal;
xlabel('x');
ylabel('y');
zlabel('z');
axis([-110 110 -110 110 -110 110]);
title('original data');
drawnow;

% standard PCA
disp('Performing standard PCA...');
Y1=PCA_diy(data,d);
figure;hold on;
plot(Y1(1:2:end,1),Y1(1:2:end,2),'b*');
plot(Y1(2:2:end,1),Y1(2:2:end,2),'ro');
legend('class 1','class 2');
title('standard PCA');
drawnow;

% Gaussian kernel PCA
figure;hold on;
Y3 = kPCA_diy(data,d);
plot(Y3(1:2:end,1),Y3(1:2:end,2),'b*');
plot(Y3(2:2:end,1),Y3(2:2:end,2),'ro');
legend('class 1','class 2');
title('Gaussian kernel PCA');
drawnow;