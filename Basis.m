function DesignMatrix = Basis(X,k)
% Returns a DesignMatrix using the Fourier basis functions
% input: the input data matrix $X \in R^{n\times 1}$ and the maximal frequency k of the Fourier basis.
% output: the design matrix $\phi \in \mathbf{R}^{n\times (2k+1)}$ using the Fourier basis functions
n = numel(X);
DesignMatrix = ones(n,2*k+1);

for l = 1:k
    DesignMatrix(:,2*l) = cos(2*pi*l*X)./l;
    DesignMatrix(:,2*l+1) = sin(2*pi*l*X)./l;
end

end