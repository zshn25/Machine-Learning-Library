function sign = binarySign(x)
% Returns the sign of a vector. (+ or -)
sign = (x>=0)*2 - ones(size(x));

end