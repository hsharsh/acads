function [x, numIter] = conjGrad(func, x, b, maxIter, epsilon)
    if nargin < 5
        epsilon = 1e-9;
    end
    if nargin < 4
        maxIter = 500;
    end
    
    r = b - feval(func, x);
    s = r;
    for numIter = 1:maxIter
        u = feval(func, s);
        alpha = dot(s,r)/dot(s,u);
        x = x+alpha*s;
        r = b - feval(func, x);
        
        if norm(r) < epsilon
            return
        end
        
        beta = -dot(r,u)/dot(s,u);
        s = r + beta*s;
    end
end