clc;
clear all;
%-----------------------------------------------

h = 0.125e-3*4;
% h = 0.127e-3*8;
% h = 0.127


% E11 = 181e9;
% E22 = 10.273e9;
% G12 = 7.17e9;
% v12 = 0.28;

E11 = 147e9;
E22 = 9e9;
G12 = 3.3e9;
v12 = 0.31;

% E11 = 369e9;
% E22 = E11/10;
% G12 = 0.5*E22;
% v12 = 0.3;

v21 = (E22/E11)*v12;
%-----------------------------------------------

Q11 = E11/(1-v12*v21);
Q22 = E22/(1-v12*v21);
Q12 = v12*E22/(1-v12*v21);
Q66 = G12;

Q = [Q11 Q12 0; Q12 Q22 0; 0 0 Q66];

%material invariants
U1 = (3*Q11+3*Q22+2*Q12+4*Q66)/8;
U2 = (Q11-Q22)/2;
U3 = (Q11+Q22-2*Q12-4*Q66)/8;
U4 = (Q11+Q22+6*Q12-4*Q66)/8;
U5 = (U1-U4)/2;

%sysmetric laminate fiber angles
% theta = [0 90 45 -45 -45 45 90 0];
% theta = [30 -30 -30 30];
% theta = [45 45 45 45];
% theta = [45 -45 -45 45];
% theta = [0 90 -45 45 45 -45 90 0];
% theta0 = [0];
theta0 = [0 90 90 0];

for orient=1:19
theta = (theta0*pi)./180;

c2 = cos(2.*theta);
c4 = cos(4.*theta);
s2 = sin(2.*theta);
s4 = sin(4.*theta);

N = length(theta); %number of lamina

Q_xy = zeros(N, 3, 3); %stiffness matrix for each lamina

for j=1:N
    Q_xy(j,1,1) = U1 + U2*c2(j) + U3*c4(j); %Q11_xy
    
    Q_xy(j,1,2) = U4 - U3*c4(j);            %Q12_xy
    Q_xy(j,2,1) = Q_xy(j,1,2);
    
    Q_xy(j,2,2) = U1 - U2*c2(j) + U3*c4(j); %Q22_xy
    
    Q_xy(j,1,3) = 0.5*U2*s2(j) + U3*s4(j);  %Q16_xy
    Q_xy(j,3,1) = Q_xy(j,1,3);
    
    Q_xy(j,2,3) = 0.5*U2*s2(j) - U3*s4(j);  %Q26_xy
    Q_xy(j,3,2) = Q_xy(j,2,3);
    
    Q_xy(j,3,3) = U5 - U3*c4(j);            %Q66_xy
end
t = h/N;

A = zeros(3,3); %laminate bending matrix
for j=1:N
    z2 = ( -N/2 + j )*t;
    z1 = z2 - t;
    A = A + squeeze(Q_xy(j,:,:)) .* ( z2 - z1 );
end

B = zeros(3,3); %laminate bending matrix
for j=1:N
    z2 = ( -N/2 + j )*t;
    z1 = z2 - t;
    B = B + squeeze(Q_xy(j,:,:)) .* ( z2^2 - z1^2 );
end
B = (1/2)*B;

D = zeros(3,3); %laminate bending matrix
t = h/N;
for j=1:N
    z2 = ( -N/2 + j )*t;
    z1 = z2 - t;
    D = D + squeeze(Q_xy(j,:,:)) .* ( z2^3 - z1^3 );
end
D = (1/3)*D;

a=inv(A);
Ex(orient)=1/a(1,1)/h;
Ey(orient)=1/a(2,2)/h;
Gxy(orient)=1/a(3,3)/h;
nuxy(orient)=-a(2,1)/a(1,1);
nuyx(orient)=-a(1,2)/a(2,2);
netasx(orient)=a(1,3)/a(3,3);
netaxs(orient)=a(3,1)/a(1,1);
netasy(orient)=a(2,3)/a(3,3);
netays(orient)=a(3,2)/a(2,2);
theta0=theta0 +5*[1 1 1 1];
end

figure
subplot(3,2,1)
plot(0:5:90,Ex)
title('Ex');
grid on;

subplot(3,2,2)
plot(0:5:90,Ey)
title('Ey');
grid on;

subplot(3,2,3)
plot(0:5:90,Gxy)
title('Gxy');
grid on;

subplot(3,2,4)
plot(0:5:90,nuxy)
title('nuxy');
grid on;

subplot(3,2,5)
plot(0:5:90,netasx);
title('netasx');
grid on;

subplot(3,2,6)
plot(0:5:90,netasy);
title('netasy');
grid on;
