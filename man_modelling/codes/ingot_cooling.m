clc
clear
close all

tic;

% Parameters
rho = 2375;
cp = 1180;
Tm = 686;   Tl = 646.5;     Ts = 580.8;
ko = 0.17;
Tc = 300;

alpha_avg = 8.25e-5;
norm_alpha = @(T) ((248.1-0.05571*(Tc+(T*(Tm-Tc))))/(rho*cp))/alpha_avg;
n = 40;
gamma = 0.1;
dl = 1/(n-1);
dt = gamma * dl^2;


% Initial conditions
tht = ones(n,n,n);                  % Initialising theta with 1
tht1 = tht;                         % Initial Condition
t = 0;                              % Tau : Dimensionless time

% Defining geometry and Boundaries
isolve = zeros(size(tht));
x = 0:dl:1; y = 0:dl:1; z = 0:dl:1;

for i = 1:n
    for j = 1:n
        for k = 1:n
            if ((x(i)-0.5)/0.45)^2 + ((y(j)-0.5)/0.3)^2 + ((z(k)-0.5)/0.3)^2 < 1
                isolve(i,j,k) = 1;
            else
                tht(i,j,k) = 0;
                tht1(i,j,k) = 0;
            end
        end
    end
end

while t <= 5
    % Updating the interior points
    for i = 1:n
        for j = 1:n
            for k = 1:n
                 if isolve(i,j,k) == 1
                    gback = gamma*norm_alpha((tht(i,j,k)+tht(i-1,j,k))/2);        gfront = gamma*norm_alpha((tht(i+1,j,k)+tht(i,j,k))/2);
                    gleft = gamma*norm_alpha((tht(i,j,k)+tht(i,j-1,k))/2);        gright = gamma*norm_alpha((tht(i,j+1,k)+tht(i,j,k))/2);
                    gbottom = gamma*norm_alpha((tht(i,j,k)+tht(i,j,k-1))/2);      gtop = gamma*norm_alpha((tht(i,j,k+1)+tht(i,j,k))/2);

                    tht1(i,j,k) = tht(i,j,k) - gback*(tht(i,j,k)-tht(i-1,j,k)) + gfront*(tht(i+1,j,k)-tht(i,j,k)) +...
                                - gleft*(tht(i,j,k)-tht(i,j-1,k)) + gright*(tht(i,j+1,k)-tht(i,j,k)) + ...
                                - gbottom*(tht(i,j,k)-tht(i,j,k-1)) + gtop*(tht(i,j,k+1)-tht(i,j,k));
                 end
            end     
        end
    end
    
    % Data export
    fs = 1-((Tc+(squeeze(tht(:,ceil(n/2),:))*(Tm-Tc)) - Tm)/(Tl-Tm)).^(1/(1-ko));
    for i = 1:n
        for j = 1:n
            for k = 1:n
                if tht(i,j,k)-(Ts-Tc)/(Tm-Tc) < 0
                    fs(i,j,k) = 1;
                end
                if isolve(i,j,k) == 0
                    fs(i,j,k) = 0;
                end
            end
        end
    end
    
    lambda = (44.6.*(Tc +(abs(tht1-tht)).*(Tm-Tc)).^(-0.359))/(dt/alpha_avg) ;
    p_str = 59.*(lambda).^(-0.5) + 120.3;
%{
    vtkwrite(['midplane-temp-time=',num2str(ceil(t*1e8),8),'.vtk'],'Temperature',Tc+(squeeze(tht(:,ceil(n/2),:))*(Tm-Tc)));
    vtkwrite(['midplane-fs-time=',num2str(ceil(t*1e8),8),'.vtk'],'fs',squeeze(fs(:,ceil(n/2),:)));
    vtkwrite(['midplane-lambda-time=',num2str(ceil(t*1e8),8),'.vtk'],'lambda-2',squeeze(lambda(:,ceil(n/2),:)));
    vtkwrite(['midplane-pstrength-time=',num2str(ceil(t*1e8),8),'.vtk'],'Proofstrength',squeeze(p_str(:,ceil(n/2),:)));
%}    
    fprintf('Time: %f - R: %f\n\n',t,sum(sum(sum(abs(fs)))));

    %Preparing for next step
    t = t + dt;
    tht = tht1;
    if(tht1-(Ts-Tc)/(Tm-Tc) < 0)
        break;
    end
end

% Final result export
fs = 1-(((Tc+(tht)*(Tm-Tc))-Tm)/(Tl-Tm)).^(1/(1-ko));
for i = 1:n
    for j = 1:n
        for k = 1:n
            if tht(i,j,k)-(Ts-Tc)/(Tm-Tc) < 0
                fs(i,j,k) = 1;
            end
            if isolve(i,j,k) == 0
                fs(i,j,k) = 0;
            end
        end
    end
end

%{
lambda = (44.6.*(Tc +(tht1-tht).*(Tm-Tc)).^(-0.359))/dt ;
p_str = 59.*(lambda).^(-0.5) + 120.3;
vtkwrite(['midplane-temp-time=',num2str(ceil(t*1e8),8),'.vtk'],'Temperature',Tc+(squeeze(tht(:,ceil(n/2),:))*(Tm-Tc)));
vtkwrite(['midplane-fs-time=',num2str(ceil(t*1e8),8),'.vtk'],'fs',squeeze(fs(:,ceil(n/2),:)));
vtkwrite(['midplane-lambda-time=',num2str(ceil(t*1e8),8),'.vtk'],'lambda-2',squeeze(lambda(:,ceil(n/2),:)));
vtkwrite(['midplane-pstrength-time=',num2str(ceil(t*1e8),8),'.vtk'],'Proofstrength',squeeze(p_str(:,ceil(n/2),:)));
%}
toc;