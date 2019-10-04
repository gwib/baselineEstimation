A_transp = transpose(A);

At_P_A = A_transp*P*A;
At_P_f = A_transp*P*f;

% estimated heights
x_hat = inv(At_P_A) * At_P_f;


% estimated corrections
v_hat = A*x_hat- f;