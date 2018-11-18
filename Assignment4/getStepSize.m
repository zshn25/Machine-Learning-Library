function stepsize=getStepSize(Y,Phi,lambda,wplus,wneg,gradplus,gradneg)  
    % given the current points and their gradients returns the stepsize
    stepsize=0.5; beta = 0.5;
    objective = LassoObjective(Y,Phi,lambda,wplus,wneg);
    wplusnew = ProjectionPositiveOrthant(wplus - stepsize*gradplus);
    wnegnew  = ProjectionPositiveOrthant(wneg - stepsize*gradneg);
    newobjective = LassoObjective(Y,Phi,lambda,wplusnew,wnegnew);

    % stepsize selection via backtracking line search 
    % (specific for projected gradient descent)
    while( newobjective > objective + gradplus'*(wplusnew-wplus)+...
            gradneg'*(wnegnew-wneg)+1/(2*stepsize)*(norm(wplusnew-wplus)^2+norm(wnegnew-wneg)^2))
        stepsize=beta*stepsize;
        wplusnew = ProjectionPositiveOrthant(wplus - stepsize*gradplus);
        wnegnew  = ProjectionPositiveOrthant(wneg - stepsize*gradneg);
        newobjective = LassoObjective(Y,Phi,lambda,wplusnew,wnegnew);
    end
end