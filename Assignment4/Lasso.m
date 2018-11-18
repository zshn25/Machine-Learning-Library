function wstar = Lasso(Y,Phi,lambda)    
% input:
% Y    - outputs (column vector of size n)
% Phi  - design matrix (size n times D)
% lambda - regularization parameter (>=0)
%
% output:
% wstar  - optimal weight vector (size D, column vector) of the Lasso

[~,dim]=size(Phi);

% in the transformed optimization problem you have two variables wplus and
% wneg - both are restricted to be positive

wplus=rand(dim,1); % the old iterate x_t
wneg =rand(dim,1); 

wplusnew=rand(dim,1); % this is the new iterate (x_{t+1})
wnegnew=rand(dim,1);
counter=1;
% stopping criterion is here the norm of difference of two iterates
while( sqrt(norm(wplus-wplusnew)^2 + norm(wneg-wnegnew)^2)>1E-7)
  
  wplus = wplusnew;
  wneg  = wnegnew;
  
  % compute the gradient 
  [gradplus,gradneg] = GradLassoObjective(Y,Phi,lambda,wplus,wneg);

  % get stepsize
  stepsize = getStepSize(Y,Phi,lambda,wplus,wneg,gradplus,gradneg);
  
  % projected gradient steps
  wplusnew = ProjectionPositiveOrthant(wplus - stepsize*gradplus);
  wnegnew  = ProjectionPositiveOrthant(wneg - stepsize*gradneg);
  
  if(rem(counter,10)==0)
    Obj = LassoObjective(Y,Phi,lambda,wplusnew,wnegnew);  
    disp(['Iteration: ',num2str(counter),' - Current Objective: ',num2str(Obj,'%1.12f'),' - stepsize: ',num2str(stepsize)]);
  end
  counter=counter+1;
end

% return the weight vector for the original Lasso problem
wstar = wplusnew - wnegnew;






 
  