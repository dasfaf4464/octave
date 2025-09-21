clear; % clear variables
clc  % clear command window

n = 100;  % 문제 크기 (원하는 대로 조절)
A = rand(n);         % 무작위 행렬
for i=1:n
    A(i,i) = sum(abs(A(i,:))) + 1;  % 대각 성분을 크게 해서 대각우세 보장
end
b = rand(n,1);

%A=[10 -1 2 0; -1 11 -1 3; 2 -1 10 -1; 0 3 -1 8];
%b=[6;25;-11;15];
n=length(A);
%xo=[0;0;0;0]
xo=zeros(n,1);
x=xo; % size
%tol=10^(-3)
tol=1e-8; % 1.0e-3
N=100;

tic;

k=1; % Step1
while k<=N % Step2
  for i=1:n % Step 3
    sumA=0;
    for j=1:n
      if j ~= i
        sumA = sumA + A(i,j)*xo(j);
      end
    end
    x(i) =  ( b(i) - sumA ) / A(i,i);
  end
  if max(abs(x-xo))/max(abs(x)) < tol % Step 4
    k, x, b-A*x
    disp("The procedure is successful.")
    break
  end
  k = k+1; % Step 5
  xo = x; % Step 6
end
disp(">>>> <<<<< ")

toc;
