clear all;

% call input script that is setting up the constants
heightEstConstants;

A_transp = transpose(A);

At_P_A = A_transp*P*A;
At_P_f = A_transp*P*f;

% estimated heights
x_hat = inv(At_P_A) * At_P_f;


% estimated corrections
v_hat = A*x_hat- f;

v_hat_transp = transpose(v_hat);
% Step 5: checking calculations
check1 = -v_hat_transp*P*f;
check2 = v_hat_transp*P*v_hat;

% Standard deviation with weight matrix P
sd_hat_0 = sqrt((v_hat_transp*P*v_hat)/(n-e));


% --- Standard deviations of the estimated heights --

% Cofactor Matrix
Q = inv(A_transp*P*A);

% Variance-Covariance Matrix of the estimated elements
C_hat = (sd_hat_0^2)*Q;

% Standard deviation of the estimated heights
s_GM18A = sqrt(C_hat(1, 1));
s_GM18B = sqrt(C_hat(2, 2));
