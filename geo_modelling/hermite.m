clc
clear
close all

x0 = 0;
x1 = 100;
y0 = 0;
y1 = 0;

dx0 = 100;
dx1 = -100;
dy0 = 100;
dy1 = -100;


u = (0:0.05:1)';

% x = (2*x0-2*x1+dx0+dx1)*u.^3 + (-3*x0+3*x1-2*dx0-dx1)*u.^2 +  dx0*u + x0;
% y = (2*y0-2*y1+dy0+dy1)*u.^3 + (-3*y0+3*y1-2*dy0-dy1)*u.^2 +  dy0*u + y0;


X = [0; 100; 100; 100];
Y = [0; 0; 100; -100];

p = [u.^3 u.^2 u ones(length(u),1);];

M_hermite = [
    2   -2  1   1
    -3  3   -2  -1
    0   0   1   0
    1   0   0   0];

x = p * M_hermite * X;
y = p * M_hermite * Y;

hold on;
% plot(x,y,'bo');
plot(x,y);
axis equal;