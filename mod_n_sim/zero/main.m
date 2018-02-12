clc
clear
close all

%{
% Incremental search

func = @(x) (x.^3-10.*x.^2+5);
fplot(func,[0,1]);
a = 0; b = 1; dx = 0.2;
[x1, x2] = incremental_search(func, a, b, dx);
disp(x1);
disp(x2);

%}

%{
% Bisection search

func = @(x) (x.^3-10.*x.^2+5);
fplot(func,[0.6,0.8]);
x1 = 0.6; x2 =0.8; tol = 1e-6;
root = bisection(func,x1,x2,tol);
disp(root);
%}


%{
% Ridders method

func = @(x) (1./((x-0.3).^2 + 0.01) - 1./((x-0.8).^2 + 0.04));
fplot(func,[-2,3]);
root = ridder(func,0.5,0.7,1e-4);
disp(root);
%}

%{
% Newton Rhapson single equation

func = @(x) (x.^3-10.*x.^2+5);
dfunc = @(x) (3.*x.^2 -20.*x);
fplot(func,[0,1]);
[root,nIter] = newton_simple(func,dfunc,0.7,1e-12);
disp(root);
disp(nIter);
%}


% Newton Rhapson simultaneous equations

xo = [0.5; 1.5];
[x, nIter] = newton('fx',xo,'Jac');       % Change the function call according to the Jacobian used.
disp(x);
disp(nIter);


% grid on;