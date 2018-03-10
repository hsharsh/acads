
Vf = 0.56;
Vm = 1-Vf;
Ef1 = 220;
Ef2 = 22;
Em = 3.3;
Gf = 25;
Gm = 1.2;
vf = 0.15;
vm = 0.37;

% x = Vf/Ef1 +Vm/Em -Vf*Vm*(vf^2*Em/Ef2+vm^2*Ef1/Em-(1+Ef1/Ef2)*(vf*vm))/(Vf*Ef1+Vm*Em);
% E2 = 1/x;

% n = @(x) (Ef2./Em -1)./(Ef2./Em + x);
% E2 = @(x) Em .* (1+x.*n(x).*Vf)./(1-n(x).*Vf);

n = @(x) (Gf/Gm -1)./(Gf/Gm + x);
G = @(x) Gm * (1+x.*n(x)*Vf)./(1-n(x)*Vf);


y = 0:0.1:15;

plot(y,G(y))
