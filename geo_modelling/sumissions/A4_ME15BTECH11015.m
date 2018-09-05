clc
clear
close all

% Define n and k here. Don't use extremely large values of k as the
% recurusion is not done bottom-up. Hence computational cost increase
% exponentially.
n = 7;  k = 3;

% Define the seven (n) points here. ith row represents ith point.
% Space separated "x y" without the quotes
p = [
    0 0;
    1 1;
    2 2;
    3 3;
    4 3;
    5 2;
    6 1;
    7 0;
    ];

% Knot vector definition.
t = zeros(n+k+1,1);
t(k+1:n+1) = 1:(n-k+1);
t(n+2:n+k+1) = n-k+2;

U = 0:0.01:n-k+2;
X = zeros(size(U));
Y = zeros(size(U));

for lmn = 1:length(U)
    u = U(lmn);
    for j = 1:n+1
        Njk = N(j-1,k,t,u);
        X(lmn) = X(lmn) + Njk*p(j,1);
        Y(lmn) = Y(lmn) + Njk*p(j,2);
    end
end

% Since t(i) <= u < t(i+1) is being used for calculating N(i,1), the code 
% doesn't calculate the last point as because the inequality is < and not <=.
% Since, the last point is same as the last point in the definition, we can explicitly define it.
X(end) = p(end,1);
Y(end) = p(end,2);

plot(X,Y);
axis equal;


% Definition of N(i,1)
function Ni1 = N1(i,u,t)
    Ni1 = 0;
    if u >= t(i+1) && u < t(i+2)
        Ni1 = 1;
    end
end

% Definition of N(i,k)
function Nik = N(i,k,t,u)    
    Nik = 0;
    if k == 1
        Nik = N1(i,u,t);
    else
        if t(i+k)-t(i+1) ~= 0
            Nik = Nik + ((u-t(i+1))*N(i,k-1,t,u))/(t(i+k)-t(i+1));
        end
        
        if t(i+k+1)-t(i+2) ~= 0
            Nik = Nik + ((t(i+k+1)-u)*N(i+1,k-1,t,u))/(t(i+k+1)-t(i+2));
        end
    end
end





