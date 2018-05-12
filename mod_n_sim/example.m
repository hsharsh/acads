function x = example(x,omega)

%     A = [3 -3 3; -3 5 1; 3 1 5];
%     b = [9 -7 12]';

    n = length(x);
    A = zeros(n);
    A(1,1) = 4; A(1,2) = -1;
    for i = 2:n-1
        A(i,i-1) = -1;
        A(i,i) = 4;
        A(i,i+1) = -1;
    end
    A(n,n-1) = -1; A(n,n) = 4;

    b = 5*ones(n,1);
    b(1) = 9;    
    y = zeros(size(x));
    for i = 1:length(b)
            y(i) = omega*((b(i) - sum(A(i,:)*x) + A(i,i)*x(i))/A(i,i)) + (1-omega)*x(i);
    end

    x = y;

%{
x(1) = omega*(9 + 3*x(2) - 3*x(3))/3 + (1-omega)*x(1);
x(2) = omega*(-7 + 3*x(1) -  x(3))/5 + (1-omega)*x(2);
x(3) = omega*(12 - 3*x(1) + x(2))/5 + (1-omega)*x(3);
%}

end