function [A,B] = fdiff(x,h,n)
    A = zeros(n);
    B = zeros(n,1);
    
    for i = 2:n-1
       A(i,i-1) = 1;
       A(i,i) = -2 + 4*h^2;
       A(i,i+1) = 1;
       B(i) = 4*h^2*x(i);
    end
    
    A(1,1) = 1; A(n,n-1) = 2;   A(n,n) = -2+4*h^2;
    B(1) = 4*h^2*x(1);  B(n) = 4*h^2*x(n);
end