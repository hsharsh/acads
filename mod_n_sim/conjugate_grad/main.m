clc
clear
close all

x = [0 0 0]';
b = [12 -1 5]';

[x, numIter] = conjGrad(@fx, x, b);
