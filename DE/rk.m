#Runge - Kutta methods y' = f(x, y)

clc; clear;

N = 20; #간격 개수
a = 0; # 시작점
b = 4; #끝점
h = (b - a) / N; #간격

x = linspace(a, b, N + 1);
y = zeros(1, N + 1);

# y' = -y + sin(x) -> 0.5 (sin(x) - cos(x)) + 1.5 e^(-x)
f = @(x, y) -1 * y + sin(x);

y(1) = 1; #초기값

%{
#RK2
for n = 1:N
    k1 = f(x(n), y(n)); #현재 기울기 (초기 a에서는 정확한 값)
    y_next = k1 * h + y(n); #오일러로 구한 다음 y(a+h)
    k2 = f(x(n + 1), y_next); # 다음 y(a+h)에서 기울기
    y(n + 1) = h * (k1 + k2) / 2 + y(n);
    #처음점이 선형으로 가니까 다음 점 입장에서는 초기 선형인 영향을 줄이고
    #다음값 입장에서는 확실한 값을 어느정도 사용
end

disp(0.5 * (sin(b) - cos(b)) + 1.5 * e^(-b));
disp(abs(y(N) - (0.5 * (sin(b) - cos(b)) + 1.5 * e^(-b))))#오차

plot(x, y)
%}

#Rk4
for n = 1:N
    k1 = f(x(n), y(n)); # 현재 기울기
    k2 = f(x(n) + 0.5 * h, y(n) + 0.5 * k1 * h); #오일러로 그려졌을 때 중점에서 기울기
    k3 = f(x(n) + 0.5 * h, y(n) + 0.5 * k2 * h); #k2를 반영한 중점에서 기울기
    k4 = f(x(n) + h, y(n) + h * k3); #k3를 기울기로 한 오일러를 이용한 그 다음점의 기울기
    y(n + 1) = y(n) + (1/6) * h * (k1 + 2 * k2 + 2 * k3 + k4); #전체 기울기의 가중평균으로 구한 최종 다음값
end

disp(0.5 * (sin(b) - cos(b)) + 1.5 * e^(-b));
disp(abs(y(N) - (0.5 * (sin(b) - cos(b)) + 1.5 * e^(-b))))#오차

plot(x, y)
