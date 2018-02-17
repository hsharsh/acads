clc
clear
close all

%{
%fdiff.m

xstart = 0; xstop = pi/2;
n = 11;
h = (xstop-xstart)/(n-1);
x = linspace(xstart,xstop,n);
[A,B] = fdiff(x,h,n);

%}

%fdiff2.m

l = 1;
p = 1;
EI = 1;
n = 1001;
xstart = 0; xstop = l/2;
h = (xstop-xstart)/(n-1);
x = linspace(xstart,xstop,n);
[A,B] = fdiff2(x,h,n);
v = A \ B;
plot(x,v);