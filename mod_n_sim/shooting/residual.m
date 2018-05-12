function r = residual(t)
	[xsol,ysol] = ode45(@deqn,[0 1], inCond(t));
%     r = ysol(length(ysol)) - 1;
    r = ysol(length(ysol)) + 1;
end

%{
y = zeros(length(xsol)-1,1);
x = zeros(length(xsol)-1,1);
for i = 2:length(xsol)-1
   y(i) = (ysol(i+1,2)-ysol(i-1,2))/(xsol(i+1)-xsol(i-1)) + 3*ysol(i,1)*ysol(i,2);
   x(i) = xsol(i);
end

plot(x,y);
grid on;
%}