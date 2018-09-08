clc
clear
close all

n = input('Enter the number of control points: ');

u = (0:0.01:1)';

X = zeros(size(u));
Y = zeros(size(u));

for i = 1:n
	x = input(['Enter the x-coordinate of point ',num2str(i),': ']);
	y = input(['Enter the y-coordinate of point ',num2str(i),': ']);

	X = X + nchoosek(n-1,i-1).*(u.^(i-1)).*((1-u).^(n-i))*x;
	Y = Y + nchoosek(n-1,i-1).*(u.^(i-1)).*((1-u).^(n-i))*y;
end

plot(X,Y);
axis equal;