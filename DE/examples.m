# HW#2 -no.2 #
clear;

N = 10; a = 1; b = 2;
x = linspace(a, b, N + 1);
h = (b - a) / N; %h = x(2)-x(1);

## 정답
c2 = (8 - 12 * sin(log(2)) - 4 * cos(log(2)));
c1 = 11/10 - c2;
ex = c1 * x + c2 ./ x.^2 - 0.3 * sin(log(x)) - 0.1 * cos(log(x));
figure(1); clf;
plot(x, ex, 'ko-')

p = @(x) -2 / x;
q = @(x) 2 / x^2;
r = @(x) sin(log(x)) / x^2;
#y'' = p(X)y' + q(x)y + r(x)

# Euler
u1(1) = 1; v1(1) = 0; u2(1) = 0; v2(1) = 1;

for i = 1:N
    u1(i + 1) = u1(i) + h * v1(i);
    v1(i + 1) = v1(i) + h * (p(x(i)) * v1(i) + q(x(i)) * u1(i) + r(x(i)));
    u2(i + 1) = u2(i) + h * v2(i);
    v2(i + 1) = v2(i) + h * (p(x(i)) * v2(i) + q(x(i)) * u2(i));
end

y = u1 + u2 * (ex(N + 1) -u1(N + 1)) / u2(N + 1);
figure(1); hold on
plot(x, y, 'r--')
# Euler end

%%% RK4 (HW#2)
y1(1) = ex(1); yp1(1) = 0;
y2(1) = 0; yp2(1) = 1;

for i = 1:N
    # first
    k1_y1 = h * yp1(i); #한칸 다음 y
    k1_yp1 = h * (p(x(i)) * yp1(i) + q(x(i)) * y1(i) + r(x(i))); # 한칸 다음의 y'

    k2_y1 = h * (yp1(i) + 0.5 * k1_yp1); # 반칸 다음 y (y' = k1_yp 가정)
    k2_yp1 = h * (p(x(i) + 0.5 * h) * (yp1(i) + 0.5 * k1_yp1) + q(x(i) + 0.5 * h) * (y1(i) + 0.5 * k1_y1) + r(x(i) + 0.5 * h)); # 반칸 다음 y'' (y' = k1_yp라 가정)

    k3_y1 = h * (yp1(i) + 0.5 * k2_yp1);
    k3_yp1 = h * (p(x(i) + 0.5 * h) * (yp1(i) + 0.5 * k2_yp1) + q(x(i) + 0.5 * h) * (y1(i) + 0.5 * k2_y1) + r(x(i) + 0.5 * h));

    k4_y1 = h * (yp1(i) + k3_yp1);
    k4_yp1 = h * (p(x(i) + h) * (yp1(i) + k3_yp1) + q(x(i) + h) * (y1(i) + k3_y1) + r(x(i) + h));

    y1(i + 1) = y1(i) + (k1_y1 + 2 * k2_y1 + 2 * k3_y1 + k4_y1) / 6;
    yp1(i + 1) = yp1(i) + (k1_yp1 + 2 * k2_yp1 + 2 * k3_yp1 + k4_yp1) / 6;

    # second
    k1_y2 = h * yp2(i);
    k1_yp2 = h * (p(x(i)) * yp2(i) + q(x(i)) * y2(i));

    k2_y2 = h * (yp2(i) + 0.5 * k1_yp2);
    k2_yp2 = h * (p(x(i) + 0.5 * h) * (yp2(i) + 0.5 * k1_yp2) + q(x(i) + 0.5 * h) * (y2(i) + 0.5 * k1_y2));

    k3_y2 = h * (yp2(i) + 0.5 * k2_yp2);
    k3_yp2 = h * (p(x(i) + 0.5 * h) * (yp2(i) + 0.5 * k2_yp2) + q(x(i) + 0.5 * h) * (y2(i) + 0.5 * k2_y2));

    k4_y2 = h * (yp2(i) + k3_yp2);
    k4_yp2 = h * (p(x(i) + h) * (yp2(i) + k3_yp2) + q(x(i) + h) * (y2(i) + k3_y2));

    y2(i + 1) = y2(i) + (k1_y2 + 2 * k2_y2 + 2 * k3_y2 + k4_y2) / 6;
    yp2(i + 1) = yp2(i) + (k1_yp2 + 2 * k2_yp2 + 2 * k3_yp2 + k4_yp2) / 6;
end

% 최종 해 조합
w = y1 + y2 * (ex(N + 1) - y1(N + 1)) / y2(N + 1);

figure(1); hold on
plot(x, w, 's--')
abs(ex - w)'
