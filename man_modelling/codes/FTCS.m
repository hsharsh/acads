clc
clear
close all

% Parameters

gamma_x = 0.25;
gamma_y = 0.25;

nx = 41;
ny = 41;

dx = 1 / (nx - 1);
dy = 1 / (ny - 1);
dt = min(gamma_x,gamma_y) * (dx)^2;


% Initial conditions
tht = zeros(nx,ny);											% Initialising theta with 1
tht1 = tht;													% Initial Condition
t = 0;														% Tau : Dimensionless time

% Plot variables
tlist = [0.0025 0.01 0.1 0.2];

while t <= 100
    disp(t);
    
    % Updating the interior points
    for i = 2:nx-1
        for j = 2:ny-1
            tht1(i,j) = tht(i,j) + gamma_x*(tht(i+1,j) - 2*tht(i,j) + tht(i-1,j)) + gamma_y*(tht(i,j+1) - 2*tht(i,j) + tht(i,j-1));
        end
    end
    
    % Updating the boundary points
    for i = 2:nx-1
        tht1(i,ny) = 1;
    end
    
    % Interpolating the corner points
    tht1(1,1)   = tht(1,2) + tht(2,1) - tht(2,2);					% Bottom Left
    tht1(1,ny)   = tht(1,ny-1) + tht(2,ny) - tht(2,ny-1);			% Top Left
    tht1(nx,1)   = tht(nx-1,1) + tht(nx,2) - tht(nx-1,2);			% Bottom Right
    tht1(nx,ny)  = tht(nx-1,ny) + tht(nx,ny-1) - tht(nx-1,ny-1);	% Top Right

    %Preparing for next step
    for lmn = 1:length(tlist)
        if abs(t-tlist(lmn)) < 1e-10
            figure;
            [X,Y] = meshgrid(0:dx:1,0:dy:1);
            contourf(X,Y,tht);
            shading interp;
            title(['Time = ', num2str(t)]);
            axis equal;
        end
    end
%     if(abs(tht-tht1) < 1e-10)
%         break;
%     end
    tht = tht1;
    t = t + dt;
end

figure;
[X,Y] = meshgrid(0:dx:1,0:dy:1);
contourf(X,Y,tht);
shading interp;
title(['Time = ', num2str(t)]);
axis equal;