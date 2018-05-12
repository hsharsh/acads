function[xnew,numIter,omega] = gaussseidal(example,x,maxIter,epsilon)
    if nargin < 4
        epsilon = 1e-9;
    end
    if nargin<3
        maxIter = 500;
    end
    k = 10;
    p =1;
    omega = 1;
    for numIter = 1:maxIter
        xold = x;
        xnew = feval(example,x,omega);
        dx = sqrt(dot((xold-xnew), (xold-xnew)));
        if dx < epsilon 
            return;
        end
        if numIter == k
            dx1 = dx;
        end
        if numIter == k+p
            omega = 2/(1+sqrt(1-((dx/dx1)^(1/p))));
        end
        x = xnew;
    end
end
