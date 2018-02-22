
% PROGRAM FOR CALCULATING THE LAST PLY FAILURE LOAD OF A GENERAL HYBRID LAMINATE   


%%%%%%%%%%%%%% Follow the sign conventions like below %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                                             %%
%                            coordinates                                                      %%
%                                                                                             %%
%      ---------------------- z(5)         /                                                  %%
%          ( ply 4 )                      /|\ +ve Z, coordinate                               %%
%      ---------------------- z(4)         |                                                  %%
%          ( ply 3 )                       |(0,0)                                             %%
%      ---------------------- z(3) (0,0)   ------------- + x coordinate                       %%
%          ( ply 2 )                                                                          %%
%      ---------------------  z(2)                                                            %% 
%          ( ply 1 )                                                                          %% 
%      ---------------------  z(1)                                                            %%
%                                                                                             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

clear all;
clc
%INPUT PARAMETRERS- OPEN Laminate_input.m AND ENTER THE VALUES AS SPECIFIED
[n,no_mat,matval,strengthval,tt,pp,forces]=Laminate_input;
%COMPUTING ABBD MATRICES
[qb,ABBD]=Compute_ABBD(n,no_mat,matval,tt,pp,forces);  
ABBD
%COMPUTING STRESS
Stress=Compute_Stress(n,pp,tt,ABBD,qb,forces);
Stress




% %COMPUTING RESERVE FACTOR
% R=Compute_Reservefactor(no_mat,n,pp,Stress,strengthval);
% R;
% N=n;
% for j=1:N
%     R1=sortrows(R',1)
%     k=1;
%     sz=size(R1);
%     sz1=sz(1);
%     R2=zeros(1,3);
%     for i=1:sz1
%         if R1(i,1)~=R1(1,1)&R1(i,3)~=R1(1,3)
%             R2(k,:)=R1(i,:);
%             k=k+1;
%             
%         end
%     end
%     R2=sortrows(R2,3);
%     sprintf('The %d failure load is \n',j)
%     forces=forces*R1(1,1)
%     Stress=Compute_Stress(n,pp,tt,ABBD,qb,forces);
%     Stress
%     R=Compute_Reservefactor(no_mat,n,pp,Stress,strengthval);
%     R
%     inc=1;
%     sz=size(R2);
%     sz1=sz(1)
%     if sz1==1
%         break
%     end
%     clear new_n
%     for i=1:sz1/2
%         new_n(i)=R2(i*2,3);
%     end
%     new_n
%     sz=size(new_n);
%     n=sz(2);
%     clear new_pp
%     for i=1:n
%         sz=size(pp);
%         sz1=sz(1);
%         for ii=1:sz1
%             if new_n(1,i)==pp(ii,1)
%                 new_pp(i,:)=pp(ii,:);
%             end
%         end
%     end
%     new_pp=sortrows(new_pp,4)
%     clear pp 
%     %MODIFIED PLY PROPERTIES AFTER REMOVING FAILED PLIES
%     pp=new_pp
%     sz=size(pp);
%     sz1=sz(1);
%     clear new_tt
%     for i=1:sz1
%         new_tt(i,1)=new_pp(i,4);
%     end
%     
%     k=1;clear tt1
%     for i=1:sz1
%         if sign(new_tt(i,1))<0
%             tt1(1,k)=new_tt(i,1);
%             k=k+1;
%         end
%         if i==1
%             if sign(new_tt(i,1))>0
%                 tt1(1,k)=new_tt(i,1);
%                 k=k+1;
%             end
%         end
%         if i~=1
%             if sign(new_tt(i,1))>0 & sign(new_tt(i-1,1))<0
%                 tt1(1,k)=0;tt1(1,k+1)=new_tt(i,1);
%                 k=k+2;
%             elseif sign(new_tt(i,1))>0
%                 tt1(1,k)=new_tt(i,1);
%                 k=k+1;
%             end
%         end
%     end
%     clear tt
%     %MODIFIED THICKNESS DETAILS AFTER REMOVING FAILED PLIES
%     tt=tt1    
%     sz=size(tt);
%     sz1=sz(2);
% %     for i=1:sz1
%         if sign(tt)<0
%             tt(1,sz1+1)=0
%         end
%         tt2=0;
%         if sign(tt)>0
%             tt2(1)=0;
%             for i=1:sz1
%                 tt2(i+1)=tt(i);
%             end
%             tt=tt2
%         end
%     clear qb
%     %COMPUTING ABBD MATRICES
%     [qb,ABBD]=Compute_ABBD(n,no_mat,matval,tt,pp,forces); 
%     %COMPUTING STRESS
%     Stress=Compute_Stress(n,pp,tt,ABBD,qb,forces);
%     Stress
%     %COMPUTING RESERVE FACTOR
%     R=Compute_Reservefactor(no_mat,n,pp,Stress,strengthval);
%     R
% end