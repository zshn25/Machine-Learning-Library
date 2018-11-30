function handles=VecToImage(Vec,XSize,YSize,VecMin,VecMax,Mode)
% each row of Vec is interpreted as an image of size XSize*Ysize
% that means size(X,2)=XSize*YSize (otherwise an error returned
% the number of rows (size(X,1)) corresponds to the number of images
% VecMin and VecMax are the minimal and maximal possible values
% e.g. for images either [0,1] or [0,255]
% 
% depending on the way the image has been translated into a vector one
% has to take either Mode=0 or Mode=1

if(size(Vec,2)~=XSize*YSize)
 error('Number of Columns of the vector does not match XSize*YSize')
else
 BSize = ceil(sqrt(size(Vec,1))); 
 BRem= rem(size(Vec,1),BSize);
 if(BRem==0) BSize2=size(Vec,1)/BSize; else BSize2=floor(size(Vec,1)/BSize)+1; end
 
 figure,
 for i=1:size(Vec,1)
   handles(i)=subplot(BSize,BSize2,i);
   A=reshape(Vec(i,:),XSize,YSize);
   if(Mode==1)
    imagesc(A',[VecMin,VecMax]);
   else
    imagesc(A,[VecMin,VecMax]);
   end
   title(['Image Nr: ',num2str(i)]);
   colormap('gray');
   axis off
 end
end