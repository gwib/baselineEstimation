% TODO: Update these to 3D
% number of independant observations
n = 33; % number of baselines !!!! should that be 11*3??
%number of unknowns
e = 6;


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
s_GM18A_X = sqrt(C_hat(1, 1));
s_GM18A_Y = sqrt(C_hat(2,2));
s_GM18A_Z = sqrt(C_hat(3,3));
s_GM18B_X = sqrt(C_hat(4, 4));
s_GM18B_Y = sqrt(C_hat(5, 5));
s_GM18B_Z = sqrt(C_hat(6,6));