function [root,nIter] = newton_simple(func,dfunc,x,tol)
    if nargin < 4
        tol = 1e-4;
    end
    
    for i = 1:30
       dx = -feval(func,x)/feval(dfunc,x);
       x = x + dx;
       
       if abs(dx) < tol
           root = x;
           nIter = i;
           return;
       end
    end
    root = NaN; nIter = NaN;
end