function [W,aparam,Offset,cparam] = GentleBoost(X,Y,MaxIter)
% implements GentleBoost (page 353) from
% Friedman, Hastie, Tibshirani: Additive logistic boosting, a statistical
% view of boosting
% input: Designmatrix X
%        Outputvector Y
%        Maximal number of iterations MaxIter
% output: an array of weight vectors W
%         the parameters of the decision stumps a*(X*w+Offset>0)+c


dim = size(X,2); % dimension of the training data
num = size(X,1); % number of training points

gamma = 1/num*ones(num,1); % weight vector - initialize uniformly (has always to sum up to one)

W = zeros(dim,MaxIter); Gamma=zeros(num,MaxIter);
ExpLoss =zeros(MaxIter,1); ZeroOneLoss=zeros(MaxIter,1);
CurF=zeros(num,1);

counter=1; Gamma(:,1)=gamma;
while(counter<=MaxIter)
    % generate random weight vector
    w = randn(dim,1); w=w/norm(w); W(:,counter)=w;
    [aparam(counter),Offset(counter),cparam(counter),Loss] = FitStump(X,Y,w,gamma);
    
    FOut = aparam(counter)*double(X*w+Offset(counter)>0)+cparam(counter); % the decisionstump
    gamma = gamma.*exp(-Y.*FOut); % update the weight vector
    gamma = gamma/sum(gamma); % normalize the weights
    Gamma(:,counter)=gamma;
    CurF = CurF + FOut; % update function
    % compute exponential and zero-one loss
    ExpLoss(counter) = sum(exp(-Y.*CurF))/num;
    ZeroOneLoss(counter) = sum(Y.*CurF <0)/num;
    disp(['Iteration: ',num2str(counter),' - ExpLoss: ',num2str(ExpLoss(counter)),...
        '- ZeroOneLoss: ',num2str(ZeroOneLoss(counter))]);
    
    counter=counter+1;
end
