#shooting method y'' = f(x, y, y')

clc; clear;
N = 20; a = 0; b = pi;
x = linspace(a, b, N + 1);
h = x(2) - x(1); #same as (b-a)/N
y1 = zeros(1, N + 1); y2 = zeros(1, N + 1); y = zeros(1, N + 1);
dy1 = zeros(1, N + 1); dy2 = zeros(1, N + 1);

first = 0; second = 0;

f = @(x, y, dy) dy + y + (-2 * (1 + x)) * cos(x) + (x - 4) * sin(x); # y'' = f(x,y, y') -? f(x, y, dy)
f_homo = @(x, y, dy) dy + y;
y1(1) = 0; y2(1) = 0; y(N + 1) = -pi; #경계값 -> 양끝에서 초기값으로 변경해야 한다.

#y'' = f(x, y , dy)
# y' = u
#u' = f(x, U, u) -> 다음 u를 구할 수 있다.
#다음 u -> 다음 y를 구한다.

#euler

%{
for n = 1:N
    k1 = f(x(n), y1(n), dy1(n)); #y''(a)
    dy1(n + 1) = k1 * h + dy1(n); #y'(a+h) = y''(a)*h + y'(a)
    y1(n + 1) = dy1(n) * h + y1(n);
end

first = y1(N + 1);

dy2(1) = 7;

for n = 1:N
    k1 = y2(n) + dy2(n);
    dy2(n + 1) = k1 * h + dy2(n);
    y2(n + 1) = dy2(n) * h + y2(n);
end

second = y2(N + 1);

c = (-pi - first) / second;
y = y1 + c * y2;
plot(x, y)
%}

for n = 1:N
    dy_k1 = f(x(n), y1(n), dy1(n)); #현재 dy의 기울기
    y_k1 = dy1(n); #현재 y의기울기
    dy_k2 = f(x(n) + h/2, y1(n) + h/2 * y_k1, dy1(n) + h/2 * dy_k1); #중점에서 dy의 기울기 y''
    y_k2 = dy_k1 * h/2 + y_k1; #중점에서 y의 기울기
    dy_k3 = f(x(n) + h/2, y1(n) + h/2 * y_k2, dy1(n) + h/2 * dy_k2);
    y_k3 = dy_k2 * h/2 + y_k2;
    dy_k4 = f(x(n) + h, y1(n) + h * y_k3, dy1(n) + h * dy_k3);
    y_k4 = dy_k3 * h + y_k3;
    dy1(n + 1) = dy1(n) + (1/6) * (dy_k1 + 2 * dy_k2 + 2 * dy_k3 + dy_k4) *h;
    y1(n + 1) = y1(n) + (1/6) * (y_k1 + 2 * y_k2 + 2 * y_k3 + y_k4) * h;
end

first = y1(N + 1);

dy2(1) = 1;

for n = 1:N
    dy_k1 = f_homo(x(n), y2(n), dy2(n)); #현재 dy의 기울기
    y_k1 = dy2(n); #현재 y의기울기
    dy_k2 = f_homo(x(n) + h/2, y2(n) + h/2 * y_k1, dy2(n) + h/2 * dy_k1); #중점에서 dy의 기울기 y''
    y_k2 = dy_k1 * h/2 + y_k1; #중점에서 y의 기울기
    dy_k3 = f_homo(x(n) + h/2, y2(n) + h/2 * y_k2, dy2(n) + h/2 * dy_k2);
    y_k3 = dy_k2 * h/2 + y_k2;
    dy_k4 = f_homo(x(n) + h, y2(n) + h * y_k3, dy2(n) + h * dy_k3);
    y_k4 = dy_k3 * h + y_k3;
    dy2(n + 1) = dy2(n) + (1/6) * (dy_k1 + 2 * dy_k2 + 2 * dy_k3 + dy_k4) * h;
    y2(n + 1) = y2(n) + (1/6) * (y_k1 + 2 * y_k2 + 2 * y_k3 + y_k4) * h;
end

second = y2(N + 1);

c = (y(N + 1) - first) / second;
y = y1 + c * y2;
plot(x, y);
