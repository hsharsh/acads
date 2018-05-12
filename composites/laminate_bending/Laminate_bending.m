clc;
clear all;
%-----------------------------------------------

% h = 0.125e-3*4;
h = 0.127e-3*8;


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
theta = [0 90 90 0];
% theta= [ 0 0 0 0 0 0 0 0];
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

M = [1.0;0.0;.0];
strain=inv(A)*M;

display(A);
display(B);
display(D);
display(M);
display(strain);

k=1;
for i=1:N
    c=cos(theta(i));s=sin(theta(i));
    Ts=[c^2 s^2 s*c;s^2 c^2 -c*s;-2*s*c 2*s*c c^2-s^2];
    z2 = ( -N/2 + i )*t;
    z1 = z2 - t;
    zc(k)=z1;zc(k+1)=z2;
    epsl(:,k)=z1*Ts*strain;
    epsl(:,k+1)=z2*Ts*strain;
    strl(:,k)=z1*Q*Ts*strain;
    strl(:,k+1)=z2*Q*Ts*strain;
    k=k+2;
end
zco=0:t/2:h;k=1;
for i=1:N
    z2 = ( -N/2 + i )*t;
    z1 = z2 - t;
    zc(k)=z1;zc(k+1)=z2;
    epsg(:,k)=z1*strain;
    epsg(:,k+1)=z2*strain;
    strg(:,k)=z1*squeeze(Q_xy(i,:,:))*strain;
    strg(:,k+1)=z2*squeeze(Q_xy(i,:,:))*strain;
    k=k+2;
end
%%%%%%% Strain plots in Material Coordinate system
subplot(3,4,1)
plot(epsl(1,:),zc)
hold on
plot(epsl(1,:),zc,'ro')
xlabel(' strain in x direction (MCS)')
ylabel('thickness')

subplot(3,4,2)
plot(epsl(2,:),zc)
hold on
plot(epsl(2,:),zc,'ro')
xlabel('strain in y direction (MCS)')
ylabel('thickness')

subplot(3,4,3)
plot(epsl(3,:),zc)
hold on
plot(epsl(3,:),zc,'ro')
xlabel('strain in xy direction (MCS)')
ylabel('thickness')

%%%%%%%%%stress plots in MCS
subplot(3,4,4)
plot(strl(1,:),zc)
hold on
plot(strl(1,:),zc,'ro')
xlabel('stress in x direction (MCS)')
ylabel('thickness')

subplot(3,4,5)
plot(strl(2,:),zc)
hold on
plot(strl(2,:),zc,'ro')
xlabel('stress in y direction (MCS)')
ylabel('thickness')

subplot(3,4,6)
plot(strl(3,:),zc)
hold on
plot(strl(3,:),zc,'ro')
xlabel('stress in xy direction (MCS)')
ylabel('thickness')


%%%%%%% Strain plots in Global Coordinate system
subplot(3,4,7)
plot(epsg(1,:),zc)
hold on
plot(epsg(1,:),zc,'ro')
xlabel(' strain in x direction (GCS)')
ylabel('thickness')

subplot(3,4,8)
plot(epsg(2,:),zc)
hold on
plot(epsg(2,:),zc,'ro')
xlabel('strain in y direction (GCS)')
ylabel('thickness')

subplot(3,4,9)
plot(epsg(3,:),zc)
hold on
plot(epsg(3,:),zc,'ro')
xlabel('strain in xy direction (GCS)')
ylabel('thickness')

%%%%%%%%%stress plots in GCS
subplot(3,4,10)
plot(strg(1,:),zc)
hold on
plot(strg(1,:),zc,'ro')
xlabel('stress in x direction (GCS)')
ylabel('thickness')

subplot(3,4,11)
plot(strg(2,:),zc)
hold on
plot(strg(2,:),zc,'ro')
xlabel('stress in y direction (GCS)')
ylabel('thickness')

subplot(3,4,12)
plot(strg(3,:),zc)
hold on
plot(strg(3,:),zc,'ro')
xlabel('stress in xy direction (GCS)')
ylabel('thickness')

