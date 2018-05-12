function [x,numIter,OM] = seidel(func,x,maxIter,epsilon)
    if nargin < 4
        epsilon = 1e-9;
    end
    if nargin <3
        maxIter = 500;
    end
    
    k = 8; p = 1; omega = 1;
    OM = [];
    for numIter = 1:maxIter
        xold = x;
        x = feval(func,x,omega);
        dx = norm(xold-x);
        if dx < epsilon
            return;
        end
        if numIter == k
            dx1 =dx;
        end
        
        if numIter == k+p
            omega = 2/(1+sqrt(1-(dx/dx1)^(1/p)));
        end
        OM = [OM; omega];
    end
end