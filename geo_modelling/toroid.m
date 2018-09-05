clc
clear
close all

u = 0:0.05:1;
w = 0:0.05:1;

for i = 1:length(u)
    for j = 1:length(w)
       X(i,j) = (1000+50*cos(2*pi*u(i)))*sin(2*pi*w(j));
       Y(i,j) = (1000+50*cos(2*pi*u(i)))*cos(2*pi*w(j));
       Z(i,j) = 50*sin(2*pi*u(i));
    end
end

surf(X,Y,Z);
