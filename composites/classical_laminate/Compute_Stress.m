function [Stress]=Compute_Stress(n,pp,tt,ABBD,qb,forces)
% MIDPLANE STRAIN
strain=inv(ABBD)*forces';
IPstrain=[strain(1);strain(2);strain(3)]
CUstrain=[strain(4);strain(5);strain(6)]
for i=1:n+1
    Strain(:,i)=IPstrain-tt(i)*CUstrain;
end
m=1;
for i=1:n
    Qbar=[qb(1,i) qb(2,i) qb(3,i);
        qb(2,i) qb(4,i) qb(5,i);
        qb(3,i) qb(5,i) qb(6,i)];
    stress(:,m)=Qbar*Strain(:,i);
    stress(:,m+1)=Qbar*Strain(:,i+1);
    m=m+2;
end

%STRESS ALONG X AND Y DIRECTION
disp('Stress along X and Y direction:');
display(sress)

m=1;
for i=1:n
    th=pp(i,3);
    s=sin(th*(pi/180));
    c=cos(th*(pi/180));
    Ttheta=[c^2 s^2 2*c*s;
        s^2 c^2 -2*c*s;
        -c*s c*s c^2-s^2];
    Stress(:,m)=Ttheta*stress(:,m);
    Stress(:,m+1)=Ttheta*stress(:,m+1);
    m=m+2;
end

%STRESS ALONG MATERIAL AXIS
disp('Stress along material axis:');
display(stress);
