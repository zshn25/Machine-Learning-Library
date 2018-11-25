function [alpha, w, TrainErrs, TestErrs] = CoordinateDescentSVM(Xtrain, ytrain, C, Xtest, ytest)
% Solves dual SVM problem using Coordinate descent method
% Inputs:   training data Xtrain: R^nxd
%           class labels ytrain: {?1, +1}
%           the error parameter: C
%           the test data: Xtest, ytest
% Outputs:  dual solution alpha,
%           the primal solution w
%           training and test errors TrainErrs, TestErrs
%           computed at each step of the coordinate descent method

    assert(sum(unique(ytrain) == [-1; 1]) == 2); % assert the class labels are -1 and 1
    assert(sum(unique(ytest) == [-1; 1]) == 2); % assert the class labels are -1 and 1
    n = size(Xtrain, 1);
    alpha = sparse(n, 1);
    w = Xtrain'*(alpha.*ytrain); % initialize the primal variable
    
    TrainErrs = []; TestErrs = [];
    
    counter = 0; iter = 0; EPS = 1e-3;
    CONVERGENCE = false; 
    while ~CONVERGENCE   
        
        r = counter+1; % choose the coordinate r
        
        % Solve the subproblem for coordinate r without any constraints:        
        index_r = logical(sparse(r,1,1,n,1));
        alpha_unconstrained = (1 - (ytrain(index_r) *...
            sum(alpha(~index_r).*ytrain(~index_r).*...
            (Xtrain(~index_r,:)*Xtrain(index_r,:)'))))...
            /ytrain(r)*ytrain(r)*dot(Xtrain(r,:),Xtrain(r,:));
        
        % Project the solution to the interval [0, C/n]
        alpha(r) = max(0, min(alpha_unconstrained, C/n));
        
        iter = iter+1;                
        % Monitor the progress of the method by computing the dual objective, dualObj:        
        dualObj = sum(alpha) - 0.5 * sum(alpha.*ytrain.*sum(Xtrain.*Xtrain,2));
        
        if rem(iter, 100) == 0
            % Display the dual objective every 100 iterations:
            display(['iter: ', num2str(iter), ' Dual Objective: ', num2str(dualObj)]);
        end
        
        % Compute the primal solution w from alpha:
        w = Xtrain'*(alpha.*ytrain);
%         w_test = Xtest'*(alpha.*ytest);
        
        % Compute the training and test errors using the current iterate alpha:
        TrainErrs = [TrainErrs; C/n*sum(max(0, 1 - ytrain.*(Xtrain*w)))];
        TestErrs = [TestErrs; C/n*sum(max(0, 1 - ytest.*(Xtest*w)))];
        
        % If the KKT conditions are satisfied upto tolerance EPS by the current iterate alpha then set CONVERGENCE = true;
        
%          if ((alpha(r) == 0) && (ytrain(r)*(Xtrain(r,:)*w) - 1 >= EPS)) ||...
%                 ((alpha(r) > 0) && (alpha(r) < C/n) && (ytrain(r)*(Xtrain(r,:)*w) - 1 == EPS)) ||...
%                 ((alpha(r) == C/n) && (ytrain(r)*(Xtrain(r,:)*w) - 1 <= EPS))
            
        if ((~isempty(find(alpha == 0)) && all(ytrain(alpha == 0) .* (Xtrain(alpha == 0,:) * w)...
                - 1 >= EPS)) ||... 
            (~isempty(find((alpha > 0) & (alpha < C/n))) && all(ytrain((alpha > 0) & (alpha < C/n)) .* (Xtrain((alpha > 0) & (alpha < C/n),:) * w)...
                - 1 == EPS)) ||... 
            (~isempty(find(alpha == C/n)) && all(ytrain(alpha == C/n) .* (Xtrain(alpha == C/n,:) * w)...
                - 1 <= EPS)))
            CONVERGENCE = 1;
        end
        counter = rem(counter+1, n);        
        
        if iter > 10000
            break;
        end
    end  

    % Compute the primal solution w from alpha:
    w = Xtrain'*(alpha.*ytrain);
    
    % Display the dual objective of the final iteration:
    display(['Final iter: ', num2str(iter), ' Dual Objective: ', num2str(dualObj)]);    
end