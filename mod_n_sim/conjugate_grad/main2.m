function main2
    clc
    n = 10;
    x = zeros(n,1);
    b = 5*ones(n,1);
    b(1) = 9;
    [x, numIter] = conjGrad(@fx, x, b);
    display(x);
    display(numIter);
end

function Ax = fx(x)
    n = 10;
    A = zeros(n);
    A(1,1) = 4; A(1,2) = -1;
    for i = 2:n-1
        A(i,i-1) = -1;
        A(i,i) = 4;
        A(i,i+1) = -1;
    end
    A(n,n-1) = -1; A(n,n) = 4;
    
    Ax = A*x;
end

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