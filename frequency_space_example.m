clear;clc;
% Parameters
n = 3; % Replace with desired value
M = [1,2,3]; % Replace with desired vector
O = [2]; % Replace with desired vector
l = length(O);
m = length(M);

% Generate B
B = zeros(n, m);
for i = 1:n
    for j = 1:m
        if i == M(j)
            B(i, j) = 1;
        end
    end
end

rank_B = rank(B);

% Generate C
C = zeros(l, n);
for j = 1:l
    for i = 1:n
        if i == O(j)
            C(j, i) = 1;
        end
    end
end

rank_C = rank(C);

D = zeros(l, m);

G = [0 1 1;1 0 1;1 1 0];

W_c = ctrb(G, B);
W_o = obsv(G, C);
rank_w_c = rank(W_c);
rank_w_o = rank(W_o);
TF =  tf(ss(G,B,C,D))

syms s;
syms g12 g13 g21 g23 g31 g32;
G = [0 g12 g13;g21 0 g23;g31 g32 0];
char_poly = charpoly(G)
I = eye(size(G));
sI_minus_G = s * I - G;
inv_sI_minus_G = inv(sI_minus_G);
result = C * inv_sI_minus_G * B

g12_val = 1;
g13_val = 1;
g21_val = 1;
g23_val = 1;
g31_val = 1;
g32_val = 1;
result_with_values = subs(result, {g12, g13, g21, g23, g31, g32}, {g12_val, g13_val, g21_val, g23_val, g31_val, g32_val})
