clc
clear
close all


E1 = 181;
E2 = 10.273;
G12 = 7.17;
v12 = 0.28;
v21 = v12;

q = [
    E1/(1-v12*v21)      v21*E1/(1-v12*v21)  0;
    v12*E2/(1-v12*v21)  E2/(1-v12*v21)      0;
    0                   0                   G12
    ];


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
nxxy = zeros(length(theta),1);
nyxy = zeros(length(theta),1);

Q11 = zeros(length(theta),1);
Q22 = zeros(length(theta),1);
Q66 = zeros(length(theta),1);
Q12 = zeros(length(theta),1);
Q16 = zeros(length(theta),1);
Q26 = zeros(length(theta),1);

for i = 1:length(theta)
    t = theta(i);
    T = trans(t);
 
    S = T' * s * T;
        
    Q = T \ q * inv(T)';

    Ex(i)   = 1/S(1,1);
    Ey(i)   = 1/S(2,2);
    Gxy(i)  = 1/S(3,3);
    vxy(i) = -Ey(i)*S(1,2);
    nxxy(i) = Ex(i)*S(3,1);
	nyxy(i) = Ey(i)*S(3,2);

    Q11(i) = Q(1,1);
    Q22(i) = Q(2,2);
    Q66(i) = Q(3,3);
    Q12(i) = Q(1,2);
    Q16(i) = Q(1,3);
    Q26(i) = Q(2,3);
end

theta = theta*(180/pi);

figure;


subplot(3,2,1)
hold on;
plot(theta,Q11);
plot(theta,Ex);
title('Q11');
legend('Q11','Ey');
xlabel('theta');

xlim([-180 180]);
grid on;


subplot(3,2,2)
hold on;
plot(theta,Q22);
plot(theta,Ey);
title('Q22');
legend('Q22','Ey');
xlabel('theta');

xlim([-180 180]);
grid on;


subplot(3,2,3)
hold on;
plot(theta,Q66);
plot(theta,Gxy);
title('Q66');
legend('Q66','Gxy');
xlabel('theta');

xlim([-180 180]);
grid on;


subplot(3,2,4)
hold on;
plot(theta,Q12);
plot(theta,vxy);
title('Q12');
legend('Q12','vxy');
xlabel('theta');

xlim([-180 180]);
grid on;


subplot(3,2,5)
hold on;
plot(theta,Q16);
plot(theta,nxxy);
title('Q16');
legend('Q16','nxxy');
xlabel('theta');

xlim([-180 180]);
grid on;


subplot(3,2,6)
hold on;
plot(theta,Q26);
plot(theta,nyxy);
title('Q26');
legend('Q26','nyxy');
xlabel('theta');

xlim([-180 180]);
grid on;