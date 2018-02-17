clc
clear
close all

x = load('quad_mesh_nodes');
conn = load('quad_mesh_elem');
nnod = length(x);
nelm = length(conn);
xgp = sqrt(3/5)*[-1 0 1];
wgp = [5 8 5]/9;
ngp = length(xgp);

kg = zeros(nnod*2);
fg = zeros(nnod*2,1);
area = 0;
for lmn = 1:nelm
    kl = zeros(4*2);
    nodes = conn(lmn,:);
    xvec = x(nodes,1); yvec = x(nodes,2);
    for i = 1:ngp
    for j=1:ngp
        r = xgp(i); s = xgp(j);
        B1 = [ -(1-s)  (1-s) (1+s) -(1+s);...
             -(1-r)  -(1+r)  (1+r)  (1-r)]/4;
        jac(1,:) = (B1*xvec)';
        jac(2,:) = (B1*yvec)';
        Bjac(1:2,1:2) = inv(jac);
        Bjac(3:4,3:4) = inv(jac);
        B0 = [1 0 0 0; 0 0 0 1; 0 1 1 0];
        B3 = zeros(4,8);
        B3(1:2, 1:2:end) = B1;
        B3(3:4, 2:2:end) = B1;
        Bjac = Bjac';
        B = B0*Bjac*B3;
        C= eye(3);C(3,3) = .5;
        kl = kl + B'*C*B *det(jac) * wgp(i) * wgp(j);
        area = area + det(jac)* wgp(i) * wgp(j);
    end
    end
    
    dof =  [nodes(1)*2-1 nodes(1)*2 ...
            nodes(2)*2-1 nodes(2)*2 ...
            nodes(3)*2-1 nodes(3)*2 ...
            nodes(4)*2-1 nodes(4)*2 ...
            ] ;
        kg (dof,dof) = kg(dof,dof) + kl;
end
left = find(x(:,1) ==0);
for ibc = 1:length(left)
   node_bc = left(ibc);
   idof = node_bc*2-1;
   kg(:,idof)= 0; kg(idof,:) =0; kg(idof,idof) =1;
   fg(idof) = 0;
end
bottom = find(x(:,2) ==0);
for ibc = 1:length(bottom)
   node_bc = bottom(ibc);
   idof = node_bc*2;
   kg(:,idof)= 0; kg(idof,:) =0; kg(idof,idof) =1;
   fg(idof) = 0;
end

right = find(x(:,1) ==1);
for ibc = 1:length(right)
   node_bc = right(ibc);
   idof = node_bc*2-1;
   fg = fg - kg(:,idof) * 0.1;
   kg(:,idof)= 0; kg(idof,:) =0; kg(idof,idof) =1;
   fg(idof) = 0.1;
end
u = kg\fg;

xf(:,1) = x(:,1) + u(1:2:end);
xf(:,2) = x(:,2) + u(2:2:end);

plot(xf(:,1),xf(:,2),'rx') 
