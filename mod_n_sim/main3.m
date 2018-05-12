function main3
    clc
    n = 3;
    x = zeros(n,1);
    [xsol,numIter,omega] = gaussseidal(@example,x);
    display(xsol);
    display(numIter);
end

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

function x = example(x,omega)
    n = length(x);
    A = [3 -3 3; -3 5 1; 3 1 5];
    b = [9 -7 12]';
    y = zeros(size(x));
    for i = 1:length(b)
            y(i) = omega*((b(i) - sum(A(i,:)*x) + A(i,i)*x(i))/A(i,i)) + (1-omega)*x(i);
    end
    x = y;
end

