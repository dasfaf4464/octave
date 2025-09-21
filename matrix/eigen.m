clc;clear;

A = [2,0,0; 1,1,2;1,-1,4]

[V, D] = eig(A)

for i = 1:10
  disp(i)
 endfor
