function FScore=FisherScore(Xtrain,Ytrain,classes)
% Returns the Fischer score of the data

ixpos = Ytrain==classes(1);
ixneg = Ytrain==classes(2);

vecpos=Xtrain(ixpos);
vecneg=Xtrain(ixneg);

mupos = mean(vecpos);
muneg = mean(vecneg);

sigma2pos = mean(vecpos.^2)-mupos^2; %var(Xtrain(ixpos));
sigma2neg = mean(vecneg.^2)-muneg^2; %var(Xtrain(ixneg));

FScore=(mupos-muneg)^2/(sigma2pos+sigma2neg);
end