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
end

theta = theta*(180/pi);

figure;

subplot(3,3,1)
plot(theta,Ex);
title('Ex');
xlabel('theta');
ylabel('Ex');
xlim([-180 180]);
grid on;

subplot(3,3,2)
plot(theta,Ey);
title('Ey');
xlabel('theta');
ylabel('Ey');
xlim([-180 180]);
grid on;

subplot(3,3,3)
plot(theta,Gxy);
title('Gxy');
xlabel('theta');
ylabel('Gxy');
xlim([-180 180]);
grid on;

subplot(3,3,4)
plot(theta,vyx);
title('vyx');
xlabel('theta');
ylabel('vyx');
xlim([-180 180]);
grid on;

subplot(3,3,5)
plot(theta,vxy);
title('vxy');
xlabel('theta');
ylabel('vxy');
xlim([-180 180]);
grid on;

subplot(3,3,6)
plot(theta,nxyx);
title('nxy,x');
xlabel('theta');
ylabel('nxy,x');
xlim([-180 180]);
grid on;

subplot(3,3,7)
plot(theta,nxyy);
title('nxy,y');
xlabel('theta');
ylabel('nxy,y');
xlim([-180 180]);
grid on;

subplot(3,3,8)
plot(theta,nxxy);
title('nx,xy');
xlabel('theta');
ylabel('nx,xy');
xlim([-180 180]);
grid on;
subplot(3,3,9)
plot(theta,nyxy);
title('ny,xy');
xlabel('theta');
ylabel('ny,xy');
xlim([-180 180]);
grid on;
