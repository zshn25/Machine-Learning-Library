function f = Prediction2(X, w, basis)
%% PREDICTION2 predicts the underlying data distribution
% *Inputs:*    $X \in \mathbf{R}^{N \times D}$ \\
               %w \in \mathbf{R}^{D \times 1}$ \\
% *Output:*   Prediction $f(X) \in \mathbf{R}^{N \times 1}$

[N, D] = size(X);
% Basis functions: Polynomial: [1 x, x^2, x^3]
DesignMatrix = [];
for b = basis
    if b == 0
        DesignMatrix = [DesignMatrix, ones(N,1)];
        continue;
    end
    DesignMatrix = [DesignMatrix, X.^b];
end

assert(size(DesignMatrix,2) == numel(w));

f = DesignMatrix * w;

end

