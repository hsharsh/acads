function root = ridder(func, x1, x2, tol)
    if nargin < 4
        tol = 1e-10;
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
        error('Root not bracketed in (x1,x2)');
        abort;
    end
    
    xo = 0;
    
    for i = 1:100
       x3 = (x1+x2)/2;
       f3 = feval(func, x3);
       
       if f3 == 0
           root = x3;
           return;
       end
       
       s = sqrt(f3^2 - f1*f2);
       
       if s <= 0
           root = NaN;
           return;
       end
       
       dx = (x3-x1)*f3/s;
       if f1 - f2 < 0
           dx = -dx;
       end
       
       x4 = x3 +dx; f4 = feval(func, x4);
       
       if i > 1
           if abs(x4-xo) < tol*max(abs(x4),1)
               root = x4;
               return;
           end
       end
       xo = x4;   
       if f1*f4 < 0
           x2 = x4; f2 = f4;
       else
           x1 = x4; f1 = f4;
       end
    end
    
    root = NaN;
end