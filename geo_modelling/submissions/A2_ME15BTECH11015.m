clc
clear
close all

% Define the paramters here. 
% (variable)x is x-coordinate of the variable.
% (variable)y is the y-coordinate of the variable.
p0x = 0;    p0y = 0;
dp0x = 50;   dp0y = 50;

p1x = 50;    p1y = 0;
dp1x = 50;   dp1y = -50;

p2x = 100;    p2y = 0;


% Calculation for the tangent vector at point 2.
dp2x = 3*p2x - 3*p0x - dp0x - 4* dp1x;
dp2y = 3*p2y - 3*p0y - dp0y - 4* dp1y;



% Parameters for plotting Hermite curve.
u = (0:0.05:1)';

p = [u.^3 u.^2 u ones(length(u),1);];

M_hermite = [
    2   -2  1   1
    -3  3   -2  -1
    0   0   1   0
    1   0   0   0];


% Hermite curve 1
X = [p0x; p1x; dp0x; dp1x];
Y = [p0y; p1y; dp0y; dp1y];

x = p * M_hermite * X;
y = p * M_hermite * Y;

plot(x,y);
hold on;


% Hermite curve 2
X = [p1x; p2x; dp1x; dp2x];
Y = [p1y; p2y; dp1y; dp2y];

x = p * M_hermite * X;
y = p * M_hermite * Y;

plot(x,y);
axis equal;