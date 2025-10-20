clc; clear;

f = @(y, yp, x) -yp + y + x;
g = @(y, yp) -yp + y;
N = 20;
x = linspace(0, 1, N);
h = x(2) - x(1);

# =========================
# linear shooting
# =========================

# 1. Euler

y1 = zeros(N, 1); y2 = zeros(N, 1);
yp1 = zeros(N, 1); yp2 = zeros(N, 1);
y1(1) = 0; yp1(1) = 0;
y2(1) = 0; yp2(1) = 1;
b = 0;

for i = 1:(N - 1)
    yp1(i + 1) = yp1(i) + f(y1(i), yp1(i), x(i)) * h;
    y1(i + 1) = y1(i) + yp1(i) * h;
endfor

for i = 1:N - 1
    yp2(i + 1) = yp2(i) + g(y2(i), yp2(i)) * h;
    y2(i + 1) = y2(i) + yp2(i) * h;
endfor

a = (b - y1(N)) / y2(N);
y = y1 + a * y2;

plot(x, y, 'bs-'); hold on;

# 2. RK4

y1 = zeros(N, 1); y2 = zeros(N, 1);
yp1 = zeros(N, 1); yp2 = zeros(N, 1);
y1(1) = 0; yp1(1) = 0;
y2(1) = 0; yp2(1) = 1;
b = 0;

for i = 1:(N - 1)
    yp1_k1 = f(y1(i), yp1(i), x(i));
    y1_k1 = yp1(i);

    yp1_k2 = f(y1(i) + y1_k1 * (h / 2), yp1(i) + yp1_k1 * (h / 2), x(i) + (h / 2));
    y1_k2 = yp1(i) + yp1_k1 * (h / 2);

    yp1_k3 = f(y1(i) + y1_k2 * (h / 2), yp1(i) + yp1_k2 * (h / 2), x(i) + (h / 2));
    y1_k3 = yp1(i) + yp1_k2 * (h / 2);

    yp1_k4 = f(y1(i) + y1_k3 * h, yp1(i) + yp1_k3 * h, x(i) + h);
    y1_k4 = yp1(i) + yp1_k3 * h;

    yp1(i + 1) = yp1(i) + ((yp1_k1 + (2 * yp1_k2) + (2 * yp1_k3) +yp1_k4) / 6) * h;
    y1(i + 1) = y1(i) + ((y1_k1 + (2 * y1_k2) + (2 * y1_k3) + y1_k4) / 6) * h;
endfor

for i = 1:(N - 1)
    yp2_k1 = g(y2(i), yp2(i));
    y2_k1 = yp2(i);

    yp2_k2 = g(y2(i) + y2_k1 * (h / 2), yp2(i) + yp2_k1 * (h / 2));
    y2_k2 = yp2(i) + yp2_k1 * (h / 2);

    yp2_k3 = g(y2(i) + y2_k2 * (h / 2), yp2(i) + yp2_k2 * (h / 2));
    y2_k3 = yp2(i) + yp2_k2 * (h / 2);

    yp2_k4 = g(y2(i) + y2_k3 * h, yp2(i) + yp2_k3 * h);
    y2_k4 = yp2(i) + yp2_k3 * h;

    yp2(i + 1) = yp2(i) + ((yp2_k1 + (2 * yp2_k2) + (2 * yp2_k3) +yp2_k4) / 6) * h;
    y2(i + 1) = y2(i) + ((y2_k1 + (2 * y2_k2) + (2 * y2_k3) + y2_k4) / 6) * h;
endfor

a = (b - y1(N)) / y2(N);
y = y1 + a * y2;

plot(x, y, 'gs:'); hold on;

legend('Euler', 'RK4');
xlabel('x'); ylabel('y'); title('BVP');
