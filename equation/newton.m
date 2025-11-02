clc; clear;

h = 1e-3;
tol = 1e-5;
max_iter = 100;

# =========================
# Newton-Raphson method
# =========================

# 1. 단변수 함수

f = @(x) exp(x) + (2 * x) + 1;
b = 3;

df = @(x, dx) (f(x + dx) - f(x - dx)) / (2 * dx);

x = 0;


for i = 1:max_iter
    x_before = x;
    x = x - (f(x) - b) / df(x, h);

    if max(abs(x - x_before)) < tol
        disp(x);
        break;
    endif

endfor

# 2. 다변수 함수 Jacobian 행렬

F1 = @(x, y, z) x^2 - sin(y) + 0.5 * cos(z) - 0.5;
F2 = @(x, y, z) 3 * x - cos(y) + sin(z);
F3 = @(x, y, z) x^2 + y^2 + z^3 - 0.95;

dF1_x = @(x, y, z, dx) (F1(x + dx, y, z) - F1(x - dx, y, z)) / (2 * dx);
dF1_y = @(x, y, z, dy) (F1(x, y + dy, z) - F1(x, y - dy, z)) / (2 * dy);
dF1_z = @(x, y, z, dz) (F1(x, y, z + dz) - F1(x, y, z - dz)) / (2 * dz);

dF2_x = @(x, y, z, dx) (F2(x + dx, y, z) - F2(x - dx, y, z)) / (2 * dx);
dF2_y = @(x, y, z, dy) (F2(x, y + dy, z) - F2(x, y - dy, z)) / (2 * dy);
dF2_z = @(x, y, z, dz) (F2(x, y, z + dz) - F2(x, y, z - dz)) / (2 * dz);

dF3_x = @(x, y, z, dx) (F3(x + dx, y, z) - F3(x - dx, y, z)) / (2 * dx);
dF3_y = @(x, y, z, dy) (F3(x, y + dy, z) - F3(x, y - dy, z)) / (2 * dy);
dF3_z = @(x, y, z, dz) (F3(x, y, z + dz) - F3(x, y, z - dz)) / (2 * dz);

F = @(x) [F1(x(1), x(2), x(3));
    F2(x(1), x(2), x(3));
    F3(x(1), x(2), x(3))];

x = [1; 2; 3];

for k = 1:max_iter
    J_mat = [dF1_x(x(1),x(2),x(3),h), dF1_y(x(1),x(2),x(3),h), dF1_z(x(1),x(2),x(3),h);
             dF2_x(x(1),x(2),x(3),h), dF2_y(x(1),x(2),x(3),h), dF2_z(x(1),x(2),x(3),h);
             dF3_x(x(1),x(2),x(3),h), dF3_y(x(1),x(2),x(3),h), dF3_z(x(1),x(2),x(3),h)];
    
    dx = - inv(J_mat)*F(x);    
   
    x = x + dx;
    
    if norm(dx) < tol
        disp(x);
        break;
    end
end