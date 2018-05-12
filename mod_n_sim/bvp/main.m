function main
    clc
    xstart = 0;
    xend = pi/2;
    n = 10;
    h = (xend-xstart)/(n-1);
    x = linspace(xstart,xend,n);
    [A,B] = finite_difference(x,h,n);
    y = A \ B;
    disp(y);
end

function [A,b] = finite_difference(x,h,n)
    A = zeros(n);
    b = zeros(n,1);
    
    for i = 2:n-1
       A(i,i-1) = 1;
       A(i,i)   = (-2+4*h^2);
       A(i,i+1) = 1;
       b(i)     = 4*h^2*x(i);
    end
    
    A(1,1)  = 1;
    A(n,n-1)= 2;
    A(n,n)  = -2+4*h^2;
    b(1)    = 4*h^2*x(1);
    b(n)    = 4*h^2*x(n);
end