% known coordinates
coord_Fest = [2813756.678; 516950.798; 5681546.661];
coord_Moh = [2815415.137; 518305.734;5680680.337];
coord_Hav = [2816111.078; 515693.222; 5680574.101];
coord_Ils = [2813724.983; 514124.344; 5681746.772];


% measured baselines
l1 = [1261.6688; 253.6125; -671.5976];
l2 = [-31.7206; -2826.4444; 200.0989];
l3 = [745.5990; -165.9953; -377.7119];
l4 = [1658.4608; 1354.9298; -866.3032];
l5 = [-2386.1162; -1568.8682; 1172.6616];
l6 = [-1608.7924; 1091.5795; 594.8372];
l7 = [-695.9285; 2612.5085; 106.2484];
l8 = [-1092.7287; 1511.1880; 300.9593];
l9 = [-777.3237; -2660.4480; 577.8077];
l10 = [516.0646; 419.6056; -293.8917];
l11 = [-396.7976; -1101.3202; 194.7104];

% A-matrix (33*6)
A = [1 0 0 0 0 0;
     0 1 0 0 0 0;
     0 0 1 0 0 0; % v1
     0 0 0 0 0 0;
     0 0 0 0 0 0;
     0 0 0 0 0 0; % v2
     0 0 0 1 0 0;
     0 0 0 0 1 0;
     0 0 0 0 0 1; % v3
     0 0 0 0 0 0;
     0 0 0 0 0 0;
     0 0 0 0 0 0; % v4
     0 0 0 0 0 0;
     0 0 0 0 0 0;
     0 0 0 0 0 0; % v5
     0 0 0 1 0 0;
     0 0 0 0 1 0;
     0 0 0 0 0 1; % v6
     0 0 0 0 0 0;
     0 0 0 0 0 0;
     0 0 0 0 0 0; % v7
     1 0 0 0 0 0;
     0 1 0 0 0 0;
     0 0 1 0 0 0; % v8
     0 0 0 1 0 0;
     0 0 0 0 1 0;
     0 0 0 0 0 1; % v9
     1 0 0 -1 0 0;
     0 1 0 0 -1 0;
     0 0 1 0 0 -1; % v10
     1 0 0 0 0 0;
     0 1 0 0 0 0;
     0 0 1 0 0 0 % v11
     ];

 
 % f-matrix
 f = [l1+coord_Fest;
     coord_Ils-coord_Fest-l2;
     l3+coord_Fest;
     coord_Moh-coord_Fest-l4;
     coord_Ils-coord_Hav-l5;
     l6+coord_Hav;
     coord_Moh-coord_Hav-l7;
     l8+coord_Hav;
     coord_Ils-l9;
     l10;
     l11+coord_Moh];
 
 % --- WEIGHT MATRIX ---

 % covariance matrix of observations
%GM18A - FEST
m0_l1 = 0.7522; 
Q_l1 = [0.00000011 0.00000001 0.00000004;
     0.00000001 0.00000005 0.00000001;
     0.00000004 0.00000001 0.00000052]; 

 
% ILS - FEST
m0_l2 = 0.8945;
Q_l2 = [0.00000011 0 0.00000010;
     0 0.00000004 0.00000001;
     0.00000010 0.00000001 0.00000047];
 

Q_l3 = [0.00000065, 0.00000001, 0.00000045;
	0.00000001, 0.00000019,-0.00000008;
	0.00000045,-0.00000008, 0.00000183];
m0_l3 = 0.5887;

Q_l4 = [0.00000017, 0.00000000, 0.00000009;
	0.00000000, 0.00000006,-0.00000003;
	0.00000009,-0.00000003, 0.00000060];
m0_l4 = 0.6478;

Q_l5 = [0.00000010, 0.00000001, 0.00000008;
	0.00000001, 0.00000004, 0.00000002;
	0.00000008, 0.00000002, 0.00000044];
m0_l5 = 0.5776;
 
Q_l6 = [0.00000063, 0.00000001, 0.00000025; 
	0.00000001, 0.00000019,-0.00000004;
	0.00000025,-0.00000004, 0.00000198];
m0_l6 = 0.3262;
 
 Q_l7 = [0.00000018, 0.00000000, 0.00000012;
	0.00000000, 0.00000006, 0.00000000;	   
	0.00000012, 0.00000000, 0.00000058];
m0_l7 = 0.2867;

Q_l8 = [0.00000015, 0.00000002, 0.00000013;
	0.00000002, 0.00000005, 0.00000005;
	0.00000013, 0.00000005, 0.00000044];
m0_l8 = 0.3639;

m0_l9 = 0.5475;
Q_l9 = [0.00000036 0.00000003 0.00000031;
	0.00000003 0.00000015 0.00000016;
	0.00000031 0.00000016 0.00000190];
 
m0_l10 = 0.4336;
Q_l10 = [0.00000026 0.00000003 0.00000004;
	0.00000003 0.00000015 0.00000013;
	0.00000004 0.00000013 0.00000140];

m0_l11 = 0.2994;
Q_l11 = [0.00000036 0.00000002 0.00000016;
	0.00000002 0.00000016 -0.00000004;
	0.00000016 -0.00000004 0.00000153];

% diagonal 3x3 matrix to fill the diagonal matrix
O = zeros(3);

% weight matrices for baseline obs
C_l1 =  inv(m0_l1^2 * Q_l1);
C_l2 = inv(m0_l2^2 * Q_l2);
C_l3 = inv(m0_l3^2 * Q_l3);
C_l4 = inv(m0_l4^2 * Q_l4);
C_l5 = inv(m0_l5^2 * Q_l5);
C_l6 = inv(m0_l6^2 * Q_l6);
C_l7 = inv(m0_l7^2 * Q_l7);
C_l8 = inv(m0_l8^2 * Q_l8);
C_l9 = inv(m0_l9^2 * Q_l9);
C_l10 = inv(m0_l10^2 * Q_l10);
C_l11 = inv(m0_l11^2 * Q_l11);

% total weight matrix
P = [C_l1 O O O O O O O O O O;
    O C_l2 O O O O O O O O O;
    O O C_l3 O O O O O O O O;
    O O O C_l4 O O O O O O O;
    O O O O C_l5 O O O O O O;
    O O O O O C_l6 O O O O O;
    O O O O O O C_l7 O O O O;
    O O O O O O O C_l8 O O O;
    O O O O O O O O C_l9 O O;
    O O O O O O O O O C_l10 O;
    O O O O O O O O O O C_l11
    ];

A_transp = transpose(A);

% Estimate coordinates with unit weight
x_hat_unit_weight = A_transp * A \ A_transp*f;


% Estimate the unknown coordinates
At_P_A = A_transp*P*A;
At_P_f = A_transp*P*f;
x_hat = At_P_A \ At_P_f;