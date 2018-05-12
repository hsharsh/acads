function F = deqn(x,y)
% 	F = [y(2); -3*y(1)*y(2)];
    F = [y(2); 9*(y(1)-1+2*x)];
end