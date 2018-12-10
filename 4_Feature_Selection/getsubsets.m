function Subsets = getsubsets()

Subsets = cell(1,2^15-1);
counter=1;
BinCodes = allsets(15);
numbers=1:15;
for i=2:size(BinCodes,1)
    Subsets{i-1}=numbers(BinCodes(i,:)==1);
end
end