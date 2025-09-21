clc; clear;

A = [4, 3, 0;3, 4, -1;0, -1, 4];
b = [24; 30; -24];
x = zeros(3,1);

tol = 1e-10;
n = 2;
x_org = [3;4;-5];
count = 0;
#
#Gauss-Seidel
while max(abs(x- x_org)/abs(x_org)) >= tol
  if(count == (n+1))
    break;
  endif
  count = count + 1;
  for i = 1:3
    line = 0;
    coef = 0;
    for j = 1:3
      if(i==j)
        coef = A(i,j);
        continue;
        endif
      line = line + (-A(i,j) * x(j,1));
      end
      x(i, 1) = (line + b(i, 1))/coef
  end
end
disp(count)

x = zeros(3,1);
count = 0;
w = 1.25;

disp("SOR")
#G-S with SOR
while max(abs(x- x_org)/abs(x_org)) >= tol
  if(count == (n+1))
    break;
  endif
  count = count + 1;
  for i = 1:3
    line = 0;
    coef = 0;
    for j = 1:3
      if(i==j)
        coef = A(i,j);
        continue;
        endif
      line = line + (-A(i,j) * x(j,1));
    end
    x(i,1) = (1-w) * x(i,1);
    x(i, 1) = x(i,1) + w*(line + b(i, 1))/coef;
    x
  end
end
disp(count)


