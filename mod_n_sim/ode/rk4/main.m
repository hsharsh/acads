clc
clear
close all

[xsol,ysol] = rk4(0,[0 1],@fexp,1,0.01);
