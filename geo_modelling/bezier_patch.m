clc
clear
close all

m = 5; n = 5;
X = [
    0 1 2 3 4;
    0 1 2 3 4;
    0 1 2 3 4;
    0 1 2 3 4;
    0 1 2 3 4;
];

Y = [
    0 0 0 0 0;
    1 1 1 1 1;
    2 2 2 2 2;
    3 3 3 3 3;
    4 4 4 4 4;
];

Z = [
    0 0 0 0 0;
    0 1 1 1 0;
    0 1 2 1 0;
    0 1 1 1 0;
    0 0 0 0 0;
];

u = 0:0.04:1;
v = 0:0.04:1;
x = zeros(length(u),length(v));
y = zeros(length(u),length(v));
z = zeros(length(u),length(v));

for k = 1:length(u)
    for l = 1:length(v)
        for i = 0:(m-1)
            for j = 0:(n-1)
                x(k,l) = x(k,l) + nchoosek(m-1,i)*(1-u(k))^(m-i-1)*(u(k)^i)*nchoosek(n-1,j)*(1-v(l))^(n-j-1)*(v(l)^j)*X(i+1,j+1);
                y(k,l) = y(k,l) + nchoosek(m-1,i)*(1-u(k))^(m-i-1)*(u(k)^i)*nchoosek(n-1,j)*(1-v(l))^(n-j-1)*(v(l)^j)*Y(i+1,j+1);
                z(k,l) = z(k,l) + nchoosek(m-1,i)*(1-u(k))^(m-i-1)*(u(k)^i)*nchoosek(n-1,j)*(1-v(l))^(n-j-1)*(v(l)^j)*Z(i+1,j+1);
            end
        end    
    end
end

surf(x,y,z);