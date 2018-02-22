clc
clear
close all

E1 = 1;
E2 = 1;
v12 = 1;
v21 = 1;
G12 = 1;

S = [
    1/E1        -v21/E2     0;
    -v12/E1     1/E2        0;
    0           0           1/G12;
    ];
