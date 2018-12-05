function [alpha,b]=getKernelSVMSolution(K,Y,C)
% usage:  [alpha,b]=getKernelSVMSolution(K,Y,C)
% input:  K has to be a symmetric and positive definite matrix (kernel matrix)
%         Y has to be a column vector (same number of rows as K) with the
%         training labels (+1 and -1)
%         C is the error parameter of the support vector machine
% output: the dual variables alpha (column vector) and the offset b 
%         classifier can be computed with: f(x)=sum_{i=1}^n k(x,x_i)alpha_i y_i + b
         

if(size(K,1)~=size(K,2))
  error('Kernel matrix is not symmetric !');
end

if(size(K,1) ~=size(Y,1))
  error('Size of kernel matrix does not match the one of the label vector ! The training labels have to be a column vector !');
end

if(C<=0)
  error('Error parameter is not positive !');
end

numTrain = size(K,1);

string=['-t 4 -c ',num2str(C)];
K1 = [(1:numTrain)', K];
model = svmtrain(Y, K1, string);

% the coefficients returned by LIBSVM are coef(i)=alpha(i)*Y(i)
coef = model.sv_coef;
% indices of the support vectors
Idx = model.SVs;
% calculates a (full) column vector with the usual coefficients alpha
alpha = zeros(size(Y,1),1);

% LIBSVM ignores the initial labels - the first labeled point is always positive 
if(Y(1)==1)
  alpha(Idx) = Y(Idx).*coef; b = -model.rho; % the offset is determined by LIBSVM
else
  alpha(Idx) = -Y(Idx).*coef; b = model.rho;
end