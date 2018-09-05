clc
clear
close all

t = 0:0.01:12*pi;

x = sin(t).*(exp(cos(t)) - 2*cos(4*t) - sin(t/12).^5);
y = cos(t).*(exp(cos(t)) - 2*cos(4*t) - sin(t/12).^5);

plot(x,y);
axis equal