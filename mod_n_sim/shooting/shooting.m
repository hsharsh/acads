clc
clear
close all


xstart = 0;
xstop = 2;
h = 0.1;
t1 = 1;
t2 = 2;
t = ridder(@residual,t1,t2);
[xsol,ysol] = ode45(@deqn,[0 2], inCond(t));
sol = [xsol ysol];
hold on;
plot(xsol,ysol(:,1))
plot(xsol,ysol(:,2))
legend('y','ydif');
grid on;

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