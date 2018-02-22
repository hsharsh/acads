function [n,no_mat,matval,strengthval,tt,pp,forces]=Laminate_input()

%%%%%%%%%%%%%%%%%%%%%%%%%% INPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 


% 1) ENTER the breadth of the laminate

      rd=1;

% 2) ENTER no of layers of the laminate

     n=6 ;% no of layers

% 3) ENTER no of ply materials - materils used 

     no_mat=2;


% Note: For entering the u21=(e2/e1)*u12 

% 4) ENTER matrl properties; matval =[  matno(1)  e1 (2)    e2 (3)  u12 (4)   u21(5)       g12];

  % matval =[  matno(1)  e1 (2)    e2 (3)   u12 (4)   u21(5)       g12(6)];
    matval = [ 1        140e3    10e3      0.3    0.0203        7e3
               2        44500     11650     0.3    0.0785        4600 ];  
%            matval = [ 1        115988    7833      0.3    0.0203        3826
%                2        44500     11650     0.3    0.0785        4600 ];
 % 5) ENTER matrl strength prop;strengthval=[ matno(1)  SL+(2)    SL-(3)  ST+(4)   ST-(5)    SLT(6)];        
    strengthval=[1   1448   1172  48.3  248  62.1
                 2   1200   1000  60   200  95];
   
% 5) Enter corodnitaes of the plylayers
    %%%%%% Note: Always give the coordiantes symmetry about Y = 0 axis

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
    
      tt=[-1.5 -1 -0.5  0  0.5  1 1.5];
    
% 6) ENTER pp = [ plyno   Material no   Plyangle coord]

             pp  = [ 1   1   0
                     2   1   90
                     3   1   0
                     4   1   0
                     5   1   90
                     6   1   0];
       
     forces=1e3*[1 0.2 0.1 0.3 0.1 0.01];         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END OF THE INPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
