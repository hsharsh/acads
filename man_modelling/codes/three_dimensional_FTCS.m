clc
clear
close all

% Parameters

gamma_x = 0.15;
gamma_y = 0.15;
gamma_z = 0.15;

nx = 11;
ny = 11;
nz = 11;

dx = 1 / (nx - 1);
dy = 1 / (ny - 1);
dz = 1 / (nz - 1);

dt = min(min(gamma_x,gamma_y),gamma_z) * (dx)^2;


% Initial conditions
tht = zeros(nx,ny,nz);                                      % Initialising theta with 1
tht1 = tht;													% Initial Condition
t = 0;														% Tau : Dimensionless time

% Plot variables
tlist = [0.0025 0.01 0.1 0.2];

while t <= 10
    disp(t);
    
    % Updating the interior points
    for i = 2:nx-1
        for j = 2:ny-1
            for k = 2:nz-1
                tht1(i,j,k) = tht(i,j,k) + gamma_x*(tht(i+1,j,k) - 2*tht(i,j,k) + tht(i-1,j,k)) + ...
                gamma_y*(tht(i,j+1,k) - 2*tht(i,j,k) + tht(i,j-1,k)) + gamma_z*(tht(i,j,k+1) - 2*tht(i,j,k) + tht(i,j,k-1));
            end
        end
    end
    
    % Updating the boundary points
    for i = 2:nx-1
        for k = 2:nz-1
            tht1(i,ny,k) = 1;
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

%     if(abs(tht-tht1) < 1e-10)
%         break;
%     end
    tht = tht1;
    t = t + dt;
end
