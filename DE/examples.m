clc; clear;
N = 10; a = 1; b = 2;
x = linspace(a, b, N + 1);
h = x(2) - x(1); #same as (b-a)/N
y1 = zeros(1, N + 1); y2 = zeros(1, N + 1); y = zeros(1, N + 1);
dy1 = zeros(1, N + 1); dy2 = zeros(1, N + 1);

first = 0; second = 0;

f = @(x, y, dy) (-2 / x) * dy + (2 / x^2) * y + (sin(log(x)) / x^2);
f_homo = @(x, y, dy) (-2 / x) * dy + (2 / x^2) * y;
y1(1) = 1; y2(1) = 0; y(N + 1) = 2;

for n = 1:N
    dy_k1 = f(x(n), y1(n), dy1(n));
    y_k1 = dy1(n);
    dy_k2 = f(x(n) + h / 2, y1(n) + h / 2 * y_k1, dy1(n) + h / 2 * dy_k1);
    y_k2 = y_k1 + dy_k1 * h / 2;
    dy_k3 = f(x(n) + h / 2, y1(n) + h / 2 * y_k2, dy1(n) + h / 2 * dy_k2);
    y_k3 = y_k2 + dy_k2 * h / 2;
    dy_k4 = f(x(n) + h, y1(n) + h * y_k3, dy1(n) + h * dy_k3);
    y_k4 = y_k3 + dy_k3 * h;
    dy1(n + 1) = dy1(n) + (1/6) * (dy_k1 + 2 * dy_k2 + 2 * dy_k3 + dy_k4) * h;
    y1(n + 1) = y1(n) + (1/6) * (y_k1 + 2 * y_k2 + 2 * y_k3 + y_k4) * h;
end

first = y1(N + 1);

dy2(1) = 1;

for n = 1:N
    dy_k1 = f_homo(x(n), y2(n), dy2(n));
    y_k1 = dy2(n);
    dy_k2 = f_homo(x(n) + h / 2, y2(n) + h / 2 * y_k1, dy2(n) + h / 2 * dy_k1);
    y_k2 = y_k1 + dy_k1 * h / 2;
    dy_k3 = f_homo(x(n) + h / 2, y2(n) + h / 2 * y_k2, dy2(n) + h / 2 * dy_k2);
    y_k3 = y_k2 + dy_k2 * h / 2;
    dy_k4 = f_homo(x(n) + h, y2(n) + h * y_k3, dy2(n) + h * dy_k3);
    y_k4 = y_k3 + dy_k3 * h;
    dy2(n + 1) = dy2(n) + (1/6) * (dy_k1 + 2 * dy_k2 + 2 * dy_k3 + dy_k4) * h;
    y2(n + 1) = y2(n) + (1/6) * (y_k1 + 2 * y_k2 + 2 * y_k3 + y_k4) * h;
end

second = y2(N + 1);

c = (y(N + 1) - first) / second;
y = y1 + c * y2;
plot(x, y);
