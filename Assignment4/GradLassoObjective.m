function [gradplus,gradminus] = GradLassoObjective(Y,Phi,lambda,wplus,wminus) 
  % returns the gradient of the objective at (wplus,wneg)
  % gradplus is the gradient wrt wplus
  % gradneg is the gradient wrt wneg
  
  gradplus = 2*Phi'*(Y - Phi * wplus) + lambda;
  gradminus = 2*Phi'*(Y - Phi * wminus) + lambda;
  
end