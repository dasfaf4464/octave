#non linear shooting ->

clc; clear;

p = @(x) 2 / x;
q = @(x) 2 / (x^2);
r = @(x) sin(log(x)) / (x^2);
f = @(x, y, dy) p(x) * dy + q(x) * y + r(x); # y'' = p(x)y' + q(x)y + r(x)

a = 1; b = 2; # x 구간 [1, 2]
m = 6.5; # 경계값 y(2)

N = 10;
x = linspace(a, b, N + 1);
h = x(2) - x(1); # 간격
dy1 = dy2 = y1 = y2 = zeros(1, N);

y1(1) = 1; y2(1) = 0; # 초기값 (경계값의 일부) y(1) = 1
dy1(1) = 0; dy2(1) = 1; # dy 초기값 (임의 설정)

#Euler
for i = 1:N
    k = p(x(i)) * dy1(i) + q(x(i)) * y1(i) + r(x(i)); # f(dy(1), y(1), x(i)) = 현재 dy의 기울기 (dy)^2
    dy1(i + 1) = k * h + dy1(i); # 다음 dy의 값
    y1(i + 1) = dy1(i) * h + y1(i); # 다음 y의 값
end
first = y1(N+1)
c = 

plot (x, y1)
