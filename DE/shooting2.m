clc; clear;

f = @(y, yp, x) (2 * y * yp) -(4 * y^2) - (2 * y) + (4 * x * e^-x) -2;
N = 20;
x = linspace(0, 1, N);
h = x(2) - x(1);

# =========================
# non-linear shooting
# =========================

# 1. 유한 차분

y = zeros(N, 1);
yp = zeros(N, 1);
t = 0.5;
y(1) = 1; yp(1) = t; b = e - 1;
tol = 1e-5;
