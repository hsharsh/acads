clc
clear
close all

% For a different problem define a different fexp
[xsol, ysol] = taylor(0,[0 1]',@fexp2,1,0.1);