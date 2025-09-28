#Euler's method y' = f(x, y)

clc; clear;

N = 20; #간격 개수
a = 0; #시작점
b = 4; #끝점
h = (b - a) / N; #간격
#x = [a:h:b];
x = linspace(a, b, N+1);
y = zeros(1, N+1);
# y' = y -> e^-2x
f = @(x, y) -2*y;

y(1) = 1; # 초기값

for n = 1:N
    y(n + 1) = f(x(n), y(n)) * h + y(n);
end

disp(e^(-2*b));
disp(abs(y(N) - e^(-2*b))) #오차

plot(x, y)
