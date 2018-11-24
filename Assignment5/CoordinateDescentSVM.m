function [alpha, w, TrainErrs, TestErrs] = CoordinateDescentSVM(Xtrain, ytrain, C, Xtest, ytest)

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
        %% Fill-in:

        
        
        % Project the solution to the interval [0, C/n]
        % Fill-in:
        
        
        
        iter = iter+1;                
        % Monitor the progress of the method by computing the dual objective, dualObj:        
        % Fill-in:
        
        
        
        if rem(iter, 100) == 0
            % Display the dual objective every 100 iterations:
            display(['iter: ', num2str(iter), ' Dual Objective: ', num2str(dualObj)]);
        end
        
        % Compute the training and test errors using the current iterate alpha:
        % Fill-in:
        
        
        
        
        % If the KKT conditions are satisfied upto tolerance EPS by the current iterate alpha then set CONVERGENCE = true;
        % Fill-in

        
               
        
        counter = rem(counter+1, n);        
        
    end  

    % Compute the primal solution w from alpha:
    % Fill-in
    
     
    
    % Display the dual objective of the final iteration:
    display(['Final iter: ', num2str(iter), ' Dual Objective: ', num2str(dualObj)]);    
end