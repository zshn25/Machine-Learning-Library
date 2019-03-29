function  [ClassSet,NumClass]=CheckLabelVector(Y)
% gets label vector as input
% checks how many different classes and gives back the label vector
ClassSet=unique(Y);
NumClass=length(ClassSet);