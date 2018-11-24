function Projw = ProjectionPositiveOrthant(w) 
% returns the projection of w onto the positive orthant
% Input: w \in R^D
% Output: projection of w onto the positive orthant

Projw = max(zeros(numel(w),1), w);