clc
close all
clear

k = 11.7;
A = conv([1 0.1],[1 4 8]);
A(end-1:end) = A(end-1:end) + [1 0.025]*(k);
sys = tf([k 0.025*k],A);
step(sys);