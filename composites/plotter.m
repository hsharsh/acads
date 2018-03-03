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

Q11 = zeros(length(theta),1);
Q22 = zeros(length(theta),1);
Q66 = zeros(length(theta),1);
Q12 = zeros(length(theta),1);
Q16 = zeros(length(theta),1);
Q26 = zeros(length(theta),1);

for i = 1:length(theta)
    t = theta(i);
    T = stiffness_transform(t);

    Ti = inv(T);
    Sd = transpose(Ti) * S * Ti;
    
    Q = T \ q * transpose(inv(T));

    Ex(i)   = 1/Sd(1,1);
    Ey(i)   = 1/Sd(2,2);
    Gxy(i)  = 1/Sd(3,3);
    gmxy(i) = -Ey(i)*Sd(2,2);
    nxyx(i) = Gxy(i)*Sd(1,3);
    nxyy(i) = Gxy(i)*Sd(2,3);

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
plot(theta,gmxy);
title('Q12');
legend('Q12','gmxy');
xlabel('theta');

xlim([-180 180]);
grid on;


subplot(3,2,5)
hold on;
plot(theta,Q16);
plot(theta,nxyx);
title('Q16');
legend('Q16','nxyx');
xlabel('theta');

xlim([-180 180]);
grid on;


subplot(3,2,6)
hold on;
plot(theta,Q26);
plot(theta,nxyy);
title('Q26');
legend('Q26','nxyy');
xlabel('theta');

xlim([-180 180]);
grid on;