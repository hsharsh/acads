function [A,B] = fdiff2(x,h,n)
    A = zeros(n);
    if(size(x,2) > 1)
       x = x';
    end
    B = zeros(n,1).*x;
    
    for i = 3:n-2
       A(i,i-2) = 1;
       A(i,i-1) = -4;
       A(i,i)   = 6;
       A(i,i+1) = -4;
       A(i,i+2) = 1;
    end
    
    A(1,1) = 1;
    A(2,2) = 7;         A(2,3) = -4;    A(2,4) = 1;
    A(n-1,n-3) = 1; A(n-1,n-2) = -4;    A(n-1,n-1) = 7; A(n-1,n) = -4;
    A(n,n-2) = 2;   A(n,n-1) = -8;       A(n,n) = 6;
    B(n) = h^3;
end


%{
%fdiff2.m

l = 1;
p = 1;
EI = 1;
n = 1001;
xstart = 0; xstop = l/2;
h = (xstop-xstart)/(n-1);
x = linspace(xstart,xstop,n);
[A,B] = fdiff2(x,h,n);
v = A \ B;
plot(x,v);
%}