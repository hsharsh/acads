clc
clear
close all



E11 = 147e9;
E22 = 9e9;
G12 = 3.3e9;
v12 = 0.31;
v21 = v12;

q = [
    E1/(1-v12*v21)      v21*E1/(1-v12*v21)  0;
    v12*E2/(1-v12*v21)  E2/(1-v12*v21)      0;
    0                   0                   G12
    ];


theta = linspace(-pi,pi);

Q11 = zeros(length(theta),1);
Q22 = zeros(length(theta),1);
Q66 = zeros(length(theta),1);
Q12 = zeros(length(theta),1);
Q16 = zeros(length(theta),1);
Q26 = zeros(length(theta),1);

for i = 1:length(theta)
    t = theta(i);
    T = trans(t);
    Q = T \ q * inv(T)';
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
plot(theta,Q11);
title('Q11');
xlabel('theta');
ylabel('Q11');
xlim([-180 180]);
grid on;

subplot(3,2,2)
plot(theta,Q22);
title('Q22');
xlabel('theta');
ylabel('Q22');
xlim([-180 180]);
grid on;

subplot(3,2,3)
plot(theta,Q66);
title('Q66');
xlabel('theta');
ylabel('Q66');
xlim([-180 180]);
grid on;

subplot(3,2,4)
plot(theta,Q12);
title('Q12');
xlabel('theta');
ylabel('Q12');
xlim([-180 180]);
grid on;

subplot(3,2,5)
plot(theta,Q16);
title('Q16');
xlabel('theta');
ylabel('Q16');
xlim([-180 180]);
grid on;

subplot(3,2,6)
plot(theta,Q26);
title('Q26');
xlabel('theta');
ylabel('Q26');
xlim([-180 180]);
grid on;