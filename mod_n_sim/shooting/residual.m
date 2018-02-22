function r = residual(t)
	[xsol,ysol] = ode45(@deqn,[0 2], inCond(t));
    r = ysol(length(ysol)) - 1;
end