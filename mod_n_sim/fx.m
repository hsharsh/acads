function f = fx(x)
    f = zeros(2,1);
    f(1) = x(1)^2 + x(2)^2 - 3;
    f(2) = x(1)*x(2) - 1;
end