clc
clear
close all

E1 = 181e9;
E2 = 10.273e9;
G12 = 7.17e9;
v12 = 0.28;
v21 = v12;

S = [
    1/E1        -v21/E2     0;
    -v12/E1     1/E2        0;
    0           0           1/G12;
    ];

theta = linspace(-pi,pi);

Ex = zeros(length(theta),1);
Ey = zeros(length(theta),1);
Gxy = zeros(length(theta),1);
gmxy = zeros(length(theta),1);
nxyx = zeros(length(theta),1);
nxyy = zeros(length(theta),1);

for i = 1:length(theta)
    t = theta(i);
    T = stiffness_transform(t);
    Ti = inv(T);
    Sd = transpose(Ti) * S * Ti;
	
	Ex(i) 	= 1/Sd(1,1);
	Ey(i) 	= 1/Sd(2,2);
	Gxy(i)  = 1/Sd(3,3);
	gmxy(i) = -Ey(i)*Sd(2,2);
	nxyx(i) = Gxy(i)*Sd(1,3);
	nxyy(i) = Gxy(i)*Sd(2,3);
end

theta = theta*(180/pi);

figure;

subplot(3,2,1)
plot(theta,Ex);
title('Ex');
xlabel('theta');
ylabel('Ex');
xlim([-180 180]);
grid on;

subplot(3,2,2)
plot(theta,Ey);
title('Ey');
xlabel('theta');
ylabel('Ey');
xlim([-180 180]);
grid on;

subplot(3,2,3)
plot(theta,Gxy);
title('Gxy');
xlabel('theta');
ylabel('Gxy');
xlim([-180 180]);
grid on;

subplot(3,2,4)
plot(theta,gmxy);
title('gmxy');
xlabel('theta');
ylabel('gmxy');
xlim([-180 180]);
grid on;

subplot(3,2,5)
plot(theta,nxyx);
title('nxyx');
xlabel('theta');
ylabel('nxyx');
xlim([-180 180]);
grid on;

subplot(3,2,6)
plot(theta,nxyy);
title('nxyy');
xlabel('theta');
ylabel('nxyy');
xlim([-180 180]);
grid on;
