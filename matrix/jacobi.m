clc; clear;

A = [10 -1 2 0; -1, 11, -1, 3; 2, -1, 10, -1; 0, 3, -1, 8];
x = zeros(4, 1);
b = [6; 25; -11; 15];

x_org = [1; 2; -1; 1]; % 정답
x_next = zeros(4, 1);

tol = 1e-7; % 반복 경계값
rep = 200; % 반복수

# ======================
# Jacobi's methods
# ======================

# 1. 원소 그대로 계산
x = zeros(4, 1);
x_next = zeros(4, 1);

for k = 1:rep

    for row_i = 1:4
        sum_x = 0;

        for col_j = 1:4

            if row_i == col_j
                continue;
            else

                sum_x = sum_x - (A(row_i, col_j) / A(row_i, row_i)) * x(col_j, 1);
            endif

        endfor

        x_next(row_i, 1) = sum_x + b(row_i, 1) / A(row_i, row_i);
    endfor

    if max(abs(x - x_next)) < tol
        x = x_next;
        disp(k)
        break;
    end

    x = x_next;

endfor

disp("시그마 그대로 계산")
disp(x)

# 2. 한 행을 계산
x = zeros(4, 1);
x_next = zeros(4, 1);

for k = 1:rep

    for row_i = 1:4;
        A_row = A(row_i, :);
        A_row(row_i) = 0;
        x_next(row_i, 1) = (-A_row * x + b(row_i, 1)) / A(row_i, row_i);
    endfor

    if max(abs(x - x_next)) < tol
        x = x_next;
        disp(k)
        break;
    end

    x = x_next;
endfor

disp("한 행 계산")
disp(x)

# 3. 벡터 자체를 계산
x = zeros(4, 1);
x_next = zeros(4, 1);

D = diag(diag(A));
R = A - D;
T = -D^(-1) * R;
c = D^(-1) * b;

for k = 1:rep
    x_next = T * x + c;

    if max(abs(x - x_next)) < tol
        x = x_next;
        disp(k)
        break;
    end

    x = x_next;
endfor

disp("반복행렬 전체 행렬 계산")
disp(x)

# ======================
# Gauss-Siedel's methods
# ======================

# 1. 원소 그대로 계산
x = zeros(4, 1);

for k = 1:rep

    for row_i = 1:4
        sum_x = 0;
        x_old = x;

        for col_j = 1:4

            if row_i == col_j
                continue
            endif

            sum_x = sum_x + (-A(row_i, col_j) * x(col_j, 1)) / A(row_i, row_i);
        endfor

        x(row_i, 1) = sum_x + b(row_i, 1) / A(row_i, row_i);
    endfor

    if max(abs(x - x_old)) < tol
        disp(k)
        break;
    endif

endfor

disp("G-S 시그마 그대로 계산")
disp(x)

# ======================
# SOR: G-S's methods
# ======================

# 1. 원소 그대로 계산

x = zeros(4, 1);
w = 1.2;

for k = 1:rep
    x_old = x;

    for row_i = 1:4
        sum_x = 0;

        for col_j = 1:4

            if row_i == col_j
                continue
            endif

            sum_x = sum_x + (-A(row_i, col_j) * x(col_j, 1)) / A(row_i, row_i);
        endfor

        x_new = sum_x + (b(row_i) / A(row_i, row_i));
        x(row_i, 1) = (1 - w) * x(row_i, 1) + w * x_new;
    endfor

    if max(abs(x - x_old)) < tol
        disp(k)
        break;
    endif

endfor

disp("SOR 시그마 그대로 계산")
disp(x)
