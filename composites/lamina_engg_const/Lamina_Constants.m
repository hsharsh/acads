clc
clear
close all

%-----------------------------------------------

% h = 0.125e-3*4;
h = 0.127e-3*4;


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
theta = [0 90 90 0];
% theta = [90 90 90 90];
% theta = [30 -30 -30 30];
% theta = [45 45 45 45];
% theta = [45 -45 -45 45];
% theta = [10 10 10 10];
theta = (theta*pi)./180;

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

display(A);
display(B);
display(D);

% Ns=[0.1 0.1 .05]';
% Ns = [0.1 0 0]';
Ns = [1 0 0]';

strain = D \ Ns;


for i=1:N
    c=cos(theta(i));s=sin(theta(i));
    Ts=[c^2 s^2 s*c;s^2 c^2 -c*s;-2*s*c 2*s*c c^2-s^2];
    str(:,i) = Ts * strain;             % Local coordinate plots
%     str(:,i) = Ts \ Q*Ts*strain;
end

zco=0:t/2:h;
k=1;

for i=1:N
    z2 = ( -N/2 + i )*t;
    z1 = z2 - t;
    zc(k)       = z1;           zc(k+1)     = z2;
    strx(k)     = str(1,i);     strx(k+1)   = str(1,i);
    stry(k)     = str(2,i);     stry(k+1)   = str(2,i);
    strxy(k)    = str(3,i);     strxy(k+1)  = str(3,i);
    k=k+2;
end
figure
subplot(2,2,1);
plot(strx,zc)
hold on
plot(strx,zc,'ro')
xlabel('Stress in x direction')
ylabel('Thickness')
grid on;

subplot(2,2,2);
plot(stry,zc)
hold on
plot(stry,zc,'ro')
xlabel('Stress in y direction')
ylabel('Thickness')
grid on;

subplot(2,2,3);
plot(strxy,zc)
hold on
plot(strxy,zc,'ro')
xlabel('Stress in xy direction')
ylabel('Thickness')
grid on;
