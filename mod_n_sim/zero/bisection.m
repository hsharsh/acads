function [root] = bisection(func, x1, x2, tol)
    if nargin < 4
        tol = 1e-4;
    end
    
    f1 = feval(func,x1);
    
    if f1 == 0
        root = x1;
        return;
    end
    
    f2 = feval(func,x2);
    
    if f2 == 0
        root = x2;
        return;
    end
    
    if f1*f2 > 0
        error('Root not braketed in (x1,x2)');
        abort;
    end
    
    n = ceil(log(abs(x1-x2)/tol)/log(2));
    
    for i = 1:n
        x3 = (x1+x2)/2;
        f3 = feval(func,x3);
        
        if f3 == 0
            root = x3;
            return;
        end
        
        if f1*f3 > 0
            x1 = x3;
            f1 = f3;
        else
            x2 = x3;
            f2 = f3;
        end
    end
    root = (x1+x2)/2;
end