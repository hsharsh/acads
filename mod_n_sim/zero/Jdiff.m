function J = Jdiff(f,x,h)
    if nargin < 3
        h = 1e-4;
    end
    
    J = zeros(length(x));
    m = length(x);
    for i = 1:m
        xx = x;
        xx(i) = xx(i) + h;
        J(:,i) = (feval(f,xx)-feval(f,x))/h;
    end
end