function w = leastSquares(DesignMatrix,Y)

w = (DesignMatrix'*DesignMatrix) \ (DesignMatrix' * Y);

end

