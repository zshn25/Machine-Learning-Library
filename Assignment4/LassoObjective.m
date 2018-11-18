function fval = LassoObjective(Y,Phi,lambda,wplus,wneg) 
  % returns the objective of the optimization problem given wplus and wneg
  
  [num,~]=size(Phi);
  fval = 1/num*norm(Y-Phi*(wplus-wneg))^2 + lambda*sum(wplus) +...
      lambda*sum(wneg);
end