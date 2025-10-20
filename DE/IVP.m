clc; clear;

f = @(x, y) -2 * y + x;
N = 10;
x = linspace(0, 1, N);
h = x(2) - x(1);

# =========================
# Euler's methods
# =========================

y = zeros(N, 1);
y(1) = 1;

for i = 1:(N - 1)
    y(i + 1) = y(i) + f(x(i), y(i)) * h;
endfor

plot(x, y, 's-'); hold on;

# =========================
# Rugge-Kutta 2
# =========================

# 1. Heun's method

y = zeros(N, 1);
y(1) = 1;

for i = 1:(N - 1)
    k1 = f(x(i), y(i));
    k2 = f(x(i) + h, y(i) + k1 * h);

    y(i + 1) = y(i) + ((k1 + k2) / 2) * h;
endfor

plot(x, y, 'ro--'); hold on;

# 2. mid-point

y = zeros(N, 1);
y(1) = 1;

for i = 1:(N - 1)
    k1 = f(x(i), y(i));
    k2 = f(x(i) + (h / 2), y(i) + k1 * (h / 2));

    y(i + 1) = y(i) + k2 * h;
endfor

plot(x, y, 'bo:'); hold on;

# =========================
# Rugge-Kutta 4
# =========================

# 1. classic

y = zeros(N, 1);
y(1) = 1;

for i = 1:(N - 1)
    k1 = f(x(i), y(i));
    k2 = f(x(i) + (h / 2), y(i) + k1 * (h / 2));
    k3 = f(x(i) + (h / 2), y(i) + k2 * (h / 2));
    k4 = f(x(i) + h, y(i) + k3 * h);

    y(i + 1) = y(i) + ((k1 + (2 * k2) + (2 * k3) + k4) / 6) * h;
endfor

plot(x, y, 'gs-'); hold on;

xlabel('x'); ylabel('y'); title('IVP');
legend('Euler', 'Heun', 'mid', 'RK4');
