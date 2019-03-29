function [PVal,FScorePerm,OrgScore]=DoPermutationTest(Xtrain,Ytrain)
% Permutation test in order to determine if the sample of both classes comes from the same distribution
% input: Xtrain, Ytrain
%       Xtrain has to be real-valued
%       Ytrain must only have two different values
% output: p-value, the scores from the permutation test, the original score
% compute the Fisher Score for the original data

OrgScore=FisherScore(Xtrain,Ytrain,classes);
n=1000; nTrain=length(Ytrain);

for i=1:n
    idx = randperm(nTrain);
    YtrainPerm=Ytrain(idx);
    
    % compute the Fisher score for the permuted data
    FScorePerm(i)=FisherScore(Xtrain,YtrainPerm,classes);
end

PVal = 1/n*sum(FScorePerm > OrgScore);

end