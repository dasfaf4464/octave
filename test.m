A = [0 1; -1, 0]
clc
det(A)
[V,D] = eig(A)
A*V - V*D
V(1,2)
V(:, 2)
