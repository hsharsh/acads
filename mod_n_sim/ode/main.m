clc
clear
close all

% For a different problem define a different fexp
[xsol, ysol] = taylor(0,1,@fexp,0.2,0.05);