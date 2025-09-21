clc; clear;
addpath('get_vectors.m');

% 일차 연립 방정식

n = 4;  % 문제 크기 (원하는 대로 조절)                                  from GPT
A = rand(n);         % 무작위 행렬                                      from GPT
for i=1:n                                                             %from GPT
    A(i,i) = sum(abs(A(i,:))) + 1;  % 대각 성분을 크게 해서 대각우세 보장  from GPT
end
b = rand(n,1); % b 열벡터를 랜덤하게 생성

A = [10 -1 2 0; -1, 11, -1, 3; 2, -1, 10, -1; 0, 3, -1, 8]; %기존 예제 행렬
vectors = get_vectors(A);
x = zeros(n,1); % 초기값 0으로 설정
b = [6;25;-11;15]; % 기존 상수벡터 값


x_org = [1; 2; -1; 1]; % 정답
x_copy = rand(n,1); %반복문 진입을 위해 random값으로 설정 -> 약간 오류 발생 가능

tol = 1e-3; % 반복 경계값
rep = 100; % 반복수

%수렴성으로 해의 정확도나 방법의 정확도를 판단 < toleration & norm (2 or inf) or other similarity measures

%%SCRIPT

%반복 1, tolerance면 종료.
tic; %시간 측정 시작

vectors = get_vectors(A); %행렬에서 행벡터 추출
count = 0; %반복수 카운팅 변수
while max(abs(x - x_copy)) >= tol %norm_inf < tolerance 이면 종료
  x_copy = x; %x 값을 한번에 바꾸기 위한 버퍼
  count = count+1; %반복수 1 증가
  for i = 1:size(A)(1) % 행렬의 행 개수만큼 반복
    vec = vectors{i}; % i행 벡터(계수들)
    coef = vec(i); % 계산에 사용할 버퍼 coef
    vec(i) = 0; %주대각 성분을 계산에서 제외하기 위해 0으로 변경
    x(i) = (-vec * x_copy + b(i)) / coef; %계산식
  end
end

disp(x)
toc; %시간 측정 종료

%gauss-seidel
x_copy = rand(n,1); %반복문 진입을 위해 random값으로 설정 -> 약간 오류 발생 가능
x = zeros(n,1); %x 값을 초기화
tic; %시간 측정 시작

vectors = get_vectors(A); %행렬에서 행벡터 추출
count = 0; %반복수 카운팅
while max(abs(x - x_copy)) >= tol %norm_inf < tolerance 이면 종료
  x_copy = x;
  count = count+1;
  for i = 1:size(A)(1)
    vec = vectors{i};
    coef = vec(i);
    vec(i) = 0;
    x(i) = (-vec * x + b(i)) / coef; %x_copy 대신 바뀐 x를 다시 대입
  end
end

disp(x)
toc;
