clc
clear
close all

% Parameters
rho = 8940;
cp = 380;
base_alpha = 1.1e-4;
norm_alpha = @(th) ((436-0.142*(300+(th*(500-300))))/(rho*cp))/base_alpha;

gamma_x = 0.1;
gamma_y = 0.1;
gamma_z = 0.1;

nx = 41;
ny = 41;
nz = 41;

dx = 1 / (nx - 1);
dy = 1 / (ny - 1);
dz = 1 / (nz - 1);
dt = min(min(gamma_x,gamma_y),gamma_z) * min((min(dx,dy)))^2;


% Initial conditions
tht = zeros(nx,ny,nz);											% Initialising theta with 1
tht1 = tht;													% Initial Condition
t = 0;														% Tau : Dimensionless time

% Plot variables
tlist = [0.0025 0.01 0.1 0.2];

while t <= 5
    disp(t);
    
    % Updating the interior points
    for i = 2:nx-1
        for j = 2:ny-1
            for k = 2:nz-1
                gback = gamma_x*norm_alpha((tht(i,j,k)+tht(i-1,j,k))/2);        gfront = gamma_x*norm_alpha((tht(i+1,j,k)+tht(i,j,k))/2);
                gleft = gamma_y*norm_alpha((tht(i,j,k)+tht(i,j-1,k))/2);        gright = gamma_y*norm_alpha((tht(i,j+1,k)+tht(i,j,k))/2);
                gbottom = gamma_z*norm_alpha((tht(i,j,k)+tht(i,j,k-1))/2);      gtop = gamma_z*norm_alpha((tht(i,j,k+1)+tht(i,j,k))/2);
                
                tht1(i,j,k) = tht(i,j,k) - gback*(tht(i,j,k)-tht(i-1,j,k)) + gfront*(tht(i+1,j,k)-tht(i,j,k)) +...
                            - gleft*(tht(i,j,k)-tht(i,j-1,k)) + gright*(tht(i,j+1,k)-tht(i,j,k)) + ...
                            - gbottom*(tht(i,j,k)-tht(i,j,k-1)) + gtop*(tht(i,j,k+1)-tht(i,j,k));

            end     
        end
    end
    
    % Updating the boundary points
    for i = 2:nx-1
        for j = 2:ny-1
            tht1(i,j,nz) = 1;
        end
    end
    
    % Interpolating the corner points
    tht1(1,1,1)     = (tht(2,1,1) + tht(1,2,1) + tht(1,1,2))/3;
    tht1(nx,1,1)    = (tht(nx-1,1,1) + tht(nx,2,1) + tht(nx,1,2))/3;
    tht1(1,ny,1)    = (tht(2,ny,1) + tht(1,ny-1,1) + tht(1,ny,2))/3;
    tht1(1,1,nz)    = (tht(2,1,nz) + tht(1,2,nz) + tht(1,1,nz-1))/3;
    tht1(nx,ny,1)   = (tht(nx-1,ny,1) + tht(nx,ny-1,1) + tht(nx,ny,2))/3;
    tht1(1,ny,nz)   = (tht(2,ny,nz) + tht(1,ny-1,nz) + tht(1,ny,nz-1))/3;
    tht1(nx,1,nz)   = (tht(nx-1,1,nz) + tht(nx,2,nz) + tht(nx,1,nz-1))/3;
    tht1(nx,ny,nz)  = (tht(nx-1,ny,nz) + tht(nx,ny-1,nz) + tht(nx,ny,nz-1))/3;

    %Preparing for next step
    for lmn = 1:length(tlist)
        if abs(t-tlist(lmn)) < 1e-10
            figure;
            [Y,Z] = meshgrid(0:dy:1,0:dz:1);
            contourf(Y,Z,squeeze(tht(:,ceil(ny/2),:)));
            title(['Midplane: Time = ', num2str(t)]);
            colorbar;
            axis equal;
        end
    end
     if(abs(tht-tht1) < 1e-10)
         break;
     end
     
    tht = tht1;
    t = t + dt;
end

figure;
[Y,Z] = meshgrid(0:dy:1,0:dz:1);
contourf(Y,Z,squeeze(tht(:,ceil(ny/2),:)));
colorbar;
title(['Midplane: Steady state (Time = ', num2str(t),')']);
axis equal;