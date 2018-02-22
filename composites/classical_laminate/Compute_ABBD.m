function [qb,ABBD]=Compute_ABBD(n,no_mat,matval,tt,pp,forces)

for mn=1:no_mat
    mprop(1,mn)=matval(mn,2)/(1-matval(mn,4)*matval(mn,5));
    mprop(2,mn)=matval(mn,3)*matval(mn,4)/(1-matval(mn,4)*matval(mn,5)) ;
    mprop(3,mn)=matval(mn,3)/(1-matval(mn,4)*matval(mn,5));
    mprop(4,mn)=matval(mn,6) ;
end

% MPROP STORES EACH MATERIAL PROP IN SINGLE COLUMN
%
%    [ Q11 (1)   Q11(2)...
%      Q12 (1)   Q12(2)...
%      Q22 (1)   Q22(2)...
%      Q66 (1)   Q66(2)... ];
%
%-----------------------------------------------------------------------

zf=[];
zi=[]; 
tt
for i=1:n
    zf(i)=tt(i+1);
    zi(i)=tt(i);
end

ta=zf-zi;
tb=zf.^2-zi.^2;
td=zf.^3-zi.^3;

ta=ta';
tb=tb';
td=td';


% the INVARIANTS calculation
   
   for nn=1:n    % for n no of layerss
       mt=pp(nn,2);
       iv=mprop(:,mt);
       q11=iv(1);
       q12=iv(2);
       q22=iv(3);
       q66=iv(4);
       
       th=pp(nn,3);%theta of that layer
       s=sin(th*(pi/180));
       c=cos(th*(pi/180));
       qb(1,nn)=q11*c^4 + 2*(q12+2*q66)*s^2*c^2+q22*s^4;
       
       qb(2,nn)=(q11+q22-4*q66)*s^2*c^2 + q12*(s^4+c^4);
       
       qb(3,nn)=(q11-q12-2*q66)*s*c^3 + (q12-q22+2*q66)*s^3*c;
       
       qb(4,nn)=q11*s^4 + 2*(q12+2*q66)*s^2*c^2+q22*c^4;
       
       qb(5,nn)=(q11-q12-2*q66)*s^3*c + (q12-q22+2*q66)*s*c^3;
       
       qb(6,nn)=(q11+ q22-2*q12-2*q66)*s^2*c^2 + q66*(s^4+c^4);
       
       [CO]=[c^4 2*c^2*s^2 s^4 c^2*s^2;
           c^2*s^2 c^4+s^4 c^2*s^2 -c^2*s^2;
           c^3*s -2*c*s*(c^2-s^2) -2*c*s^3 -c*s*(c^2-s^2);
           s^4 2*c^2*s^2 c^4 c^2*s^2;
           2*c*s^3 2*c*s*(c^2-s^2) -2*c^3*s c*s*(c^2-s^2);
           4*c^2*s^2 -8*c^2*s^2 4*c^2*s^2 (c^2-s^2)^2];
       [Q]=[CO]*[q11 q12 q22 q66]';
       
   end
       
   % calculating ABD matrix 
   AA=qb*ta;
   BB=(1/2)*qb*tb;
   DD=(1/3)*qb*td;
   a11=AA(1);
   a12=AA(2);
   a16=AA(3);
   a22=AA(4);
   a26=AA(5);
   a66=AA(6);
   
   b11=BB(1);
   b12=BB(2);
   b16=BB(3);
   b22=BB(4);
   b26=BB(5);
   b66=BB(6);
   
   d11=DD(1);
   d12=DD(2);
   d16=DD(3);
   d22=DD(4);
   d26=DD(5);
   d66=DD(6);
   
   
   ABBD =[a11 a12  a16     b11 b12  b16
          a12 a22  a26     b12 b22  b26
          a16 a26  a66     b16 b26  b66
          b11 b12  b16     d11 d12  d16
          b12 b22  b26     d12 d22  d26    
          b16 b26  b66     d16 d26  d66]; 