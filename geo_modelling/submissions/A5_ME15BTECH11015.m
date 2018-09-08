clc
clear
close all

% These parameters define the shape of the gastropod shell and can be
% tweaked to get different types of shell.

p = 20;                 % Pitch
r = 10;                 % Radius 1
s = 15;                 % Radius 2
l = 15;                 % Pictch reduction factor
m = 8;                  % Radius 2 reduction factor
n = 10;                 % Radius 1 reduction factor
                 

u = 0:0.02:m;
v = 0:0.02:n;


X = zeros(length(u),length(v));
Y = zeros(length(u),length(v));
Z = zeros(length(u),length(v));

for i = 1:length(u)
    for j = 1:length(v)
       X(i,j) = (s*(1-u(i)/m)+r*(1-u(i)/n)*cos(2*pi*v(j)))*cos(2*pi*u(i));
       Y(i,j) = (s*(1-u(i)/m)+r*(1-u(i)/n)*cos(2*pi*v(j)))*sin(2*pi*u(i));
       Z(i,j) = p*(1-u(i)/l)*u(i)+r*(1-u(i)/n)*sin(2*pi*v(j));
    end
end

surf(X,Y,Z);
axis equal;