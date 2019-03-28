function AUC=PlotROC(Y,varargin)
% plots the ROC curve and computes the AUC for several classifiers
% given:
% Y: test labels (has to be in format (-1,1))
% varargin: output of different classifiers

if(nargin==1)
 error('No classifier provided !');
else
 Num=length(Y);
 for j=1:size(varargin{1,1},2)
  if(size(varargin{1,1},1)~=Num)
   error('Classification output has not the same length as test label vector !');
  end
  f(:,j)=varargin{1,1}(:,j);
 end
end

% number of positive and negative examples in the test vector
Pos = sum(Y==1);
Neg = sum(Y==-1);

NumClassifier=size(f,2);


% sort classifier output in decreasing order
[SortIdx,Idx]=sort(f,1,'descend');

% sort the label vector in the order given by f
YClass=Y(Idx);

% colors for the individual classifiers
colors = {'red','blue','black','green','magenta','cyan','yellow'};
if(length(colors)<NumClassifier)
 colors=mat2cell(colormap(jet(1000)), ones(1000,1),3);
 display('Warning: Too many classes, no generic colors ! Colors are generated from Colormap Jet !');
end

figure,
hold on,

xp=zeros(Num+1,NumClassifier); yp=zeros(Num+1,NumClassifier);
for j=1:NumClassifier
  i=1;
  while(i<=Num)
      
   % search for ties in the prediction vector
   if(i<Num & f(Idx(i,j),j)==f(Idx(i+1,j),j))
    SameValIdx = find(f(Idx(:,j),j)==f(Idx(i,j),j));
   else
    SameValIdx = [];
   end
   
   
   if(length(SameValIdx)<=1)
     if(YClass(i,j)==1)  
      xp(i+1,j)=xp(i,j); yp(i+1,j)=yp(i,j)+1/Pos; % if label is positive move up by 1/P
     else
      xp(i+1,j)=xp(i,j)+1/Neg; yp(i+1,j)=yp(i,j); % if label is negative move to the right by 1/N
     end 
     % plot the 
     if(i<Num & f(Idx(i,j),j)>0 & f(Idx(i+1,j),j)<0)
      plot(0.5*(xp(i,j)+xp(i+1,j)),0.5*(yp(i,j)+yp(i+1,j)),'MarkerFaceColor',colors{j},'MarkerEdgeColor','black','Marker','o','LineStyle','none','MarkerSize',8);
     end
     i=i+1;
   else
    numSameVal=length(SameValIdx);
    PosSameVal=sum(YClass(SameValIdx,j)==1);
    NegSameVal=sum(YClass(SameValIdx,j)==-1); 
    for t=1:numSameVal
      xp(i+t,j)=xp(i,j)+t/numSameVal*NegSameVal/Neg;  yp(i+t,j)=yp(i,j)+t/numSameVal*PosSameVal/Pos; 
    end
    i=i+numSameVal;
   end
   
   
  end
end

% compute area under the curve - note that the trapezoidal rule is valid
% since linear interpolation between points makes sense(convexification)
for j=1:NumClassifier
 AUC(j)=trapz(xp(:,j),yp(:,j));
end

% alternatively compute the AUC not by numerical integration but using the
% statistics in the lecture notes
for j=1:NumClassifier
  PosPred = f(Y==1,j);
  NegPred = f(Y==-1,j);
  counter=0; for i=1:Pos, counter=counter+ sum(PosPred(i)>NegPred)+0.5*sum(PosPred(i)==NegPred); end
  counter = counter/Pos/Neg
  AUC2(j) = counter;
  diff(j)=AUC2(j)-AUC(j)
end

% compute error assuming that one uses the standard threshold zero
for j=1:NumClassifier
 ERR(j)=sum(sign(f(:,j))~=Y)/Num;
end

for j=1:NumClassifier
  hROC(j)=plot(xp(:,j),yp(:,j),'Color',colors{j},'LineWidth',3);
end
axis([0 1 0 1]);
string=[''];
for j=1:NumClassifier
 string{j}= ['Classifier ',num2str(j),', AUC=',num2str(AUC(j),'%1.3f'),', Err=',num2str(ERR(j),'%1.3f')];
end
set(gca,'FontSize',25);
xlabel('False positive rate','FontSize',28);
ylabel('True positive rate','FontSize',28);
legend(hROC,string,'Location','SouthEast','FontSize',25);
title('ROC curve together with the AUC','FontSize',30);
%hold off
hold off

  

