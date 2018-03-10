clc
clear
close all

E1 = 181e9;
E2 = 10.273e9;
G12 = 7.17e9;
v12 = 0.28;
v21 = v12;

s = [
    1/E1        -v21/E2     0;
    -v12/E1     1/E2        0;
    0           0           1/G12;
    ];

theta = linspace(-pi,pi);

Ex = zeros(length(theta),1);
Ey = zeros(length(theta),1);
Gxy = zeros(length(theta),1);
vxy = zeros(length(theta),1);
vyx = zeros(length(theta),1);
nxyx = zeros(length(theta),1);
nxyy = zeros(length(theta),1);
nxxy = zeros(length(theta),1);
nyxy = zeros(length(theta),1);

for i = 1:length(theta)
    t = theta(i);
    T = trans(t);
    S = T' * s * T;
	
	Ex(i) 	= 1/S(1,1);
	Ey(i) 	= 1/S(2,2);
	Gxy(i)  = 1/S(3,3);
	vyx(i) = -Ey(i)*S(1,2);
    vxy(i) = -Ex(i)*S(2,1);
	nxyx(i) = Gxy(i)*S(1,3);
	nxyy(i) = Gxy(i)*S(2,3);
    nxxy(i) = Ex(i)*S(3,1);
	nyxy(i) = Ey(i)*S(3,2);