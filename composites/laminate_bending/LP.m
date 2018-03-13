clear all
% h=8*0.005*0.02544;
% x=X-0.5;
% y=x;
% E11 = 181e9;
% E22 = 10.273e9;
% G12 = 7.1705e9;
% v12 = 0.28;

E11 = 147e9;
E22 = 9e9;
G12 = 3.3e9;
v12 = 0.31;


% E11 = 140e3;
% E22 = 10e3;
% G12 = 7e3;
% v12 = 0.3;
v21 = (E22/E11)*v12;

Q11 = E11/(1-v12*v21);
Q22 = E22/(1-v12*v21);
Q12 = v12*E22/(1-v12*v21);
Q66 = G12;

U1 = (3*Q11+3*Q22+2*Q12+4*Q66)/8;
U2 = (Q11-Q22)/2;
U3 = (Q11+Q22-2*Q12-4*Q66)/8;
U4 = (Q11+Q22+6*Q12-4*Q66)/8;
U5 = (U1-U4)/2;
global GAMMA_1 GAMMA_2 GAMMA_3 GAMMA_4
GAMMA_0 = [U1 U4 0; U4 U1 0; 0 0 U5];
GAMMA_1 = [U2 0 0; 0 -U2 0; 0 0 0];
GAMMA_3 = [0 0 U2/2; 0 0 U2/2; U2/2 U2/2 0];
GAMMA_2 = [U3 -U3 0; -U3 U3 0; 0 0 -U3];
GAMMA_4 = [0 0 U3; 0 0 -U3; U3 -U3 0];
layup=[0 0 0 0 0 0 0 0];
n_layer=length(layup);
t_tow=0.127e-3;
h=t_tow*n_layer;
xi_A1 = 0;
xi_A2 = 0;
xi_A3 = 0;
xi_A4 = 0;
xi_B1 = 0;
xi_B2 = 0;
xi_B3 = 0;
xi_B4 = 0;
xi_D1 = 0;
xi_D2 = 0;
xi_D3 = 0;
xi_D4 = 0;
for k=1:n_layer
    %theta
    theta = layup(k)*pi/180;    
    
    c2 = cos(2*theta);
    c4 = cos(4*theta);
    s2 = sin(2*theta);
    s4 = sin(4*theta);

    z2 = ( -n_layer/2 + k )*t_tow/h;
    z1 = z2 - t_tow/h;    
    
    xi_A1 = xi_A1 + ((z2 - z1)*c2);
    xi_A2 = xi_A2 + ((z2 - z1)*c4);
    xi_A3 = xi_A3 + ((z2 - z1)*s2);
    xi_A4 = xi_A4 + ((z2 - z1)*s4);
    
    xi_B1 = xi_B1 + (((z2^2 - z1^2)/2)*c2)*4;
    xi_B2 = xi_B2 + (((z2^2 - z1^2)/2)*c4)*4;
    xi_B3 = xi_B3 + (((z2^2 - z1^2)/2)*s2)*4;
    xi_B4 = xi_B4 + (((z2^2 - z1^2)/2)*s4)*4;

    xi_D1 = xi_D1 + (((z2^3 - z1^3)/3)*c2)*12;
    xi_D2 = xi_D2 + (((z2^3 - z1^3)/3)*c4)*12;
    xi_D3 = xi_D3 + (((z2^3 - z1^3)/3)*s2)*12;
    xi_D4 = xi_D4 + (((z2^3 - z1^3)/3)*s4)*12;
end
A = h*(GAMMA_0 + xi_A1*GAMMA_1 + xi_A2*GAMMA_2 + xi_A3*GAMMA_3 + xi_A4*GAMMA_4)
B = (h^2/4)*(xi_B1*GAMMA_1 + xi_B2*GAMMA_2 + xi_B3*GAMMA_3 +xi_B4*GAMMA_4)
D = (h^3/12)*(GAMMA_0 + xi_D1*GAMMA_1 + xi_D2*GAMMA_2 + xi_D3*GAMMA_3 +xi_D4*GAMMA_4)