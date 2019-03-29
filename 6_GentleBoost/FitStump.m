function [a,b,c,minerror]=FitStump(X,Y,w,gamma)
%  given the fixed vector w \in R^d and the weights \gamma \in R^n
% (number of training points) derives the optimal decision stump paramters
LinOut=X*w;
[SortLinOut,Idx]=sort(LinOut,'descend'); % order the projected data in descending order
Product = Y.*gamma;
Product=Product(Idx); % reorder the product of weights and gamma as LinOut
Gamma=gamma(Idx); % reorder the weights gamma as LinOut

% cumulative sum of Product - since a,c are not defined if b<min(LinOut) or
% b>max(LinOut) we cut the possible values
CumProduct = cumsum(Product); CumProduct=CumProduct(1:end-1);
CumGamma = cumsum(Gamma); CumGamma = CumGamma(1:end-1); % same procedure for gamma
% compute optimal coefficient c for every possible threshold (there are at most n+1 different ones)
c = (sum(Product)-CumProduct)./(sum(Gamma)-CumGamma);
a = CumProduct./CumGamma - c; % computes optimal coefficient a for every possiblethreshold
% compute the error for the optimal parameters for all thresholds
%error = sum(gamma.*(Y- a*( LinOut + b)>0 - c).^2);
error = (1+c.^2).*sum(gamma) + (a.^2 + 2.*a.*c).*CumGamma -2*a.*CumProduct - 2*c.*sum(Product);
minerror = min(error);
thresh = find(error == minerror); % find indices which achieve minimal error
numTresh = length(thresh); IdxThresh = ceil(numTresh/2); % if there is more thanone take the middle one
thresh = thresh(IdxThresh);
b=-(SortLinOut(thresh)+ SortLinOut(thresh+1))*0.5; % threshold is placed in themiddle
a=a(thresh); c=c(thresh);

end