clear all;
% number of independant observations
n = 7;
%number of unknowns
e = 2;

% weight matrix, computed from sds
P = [1 0 0 0 0 0 0;
    0 2.56 0 0 0 0 0;
    0 0 0.64 0 0 0 0;
    0 0 0 0.36 0 0 0;
    0 0 0 0 1.96 0 0
    0 0 0 0 0 1 0;
    0 0 0 0 0 0 0.64];

% A-matrix
A = [1 0;
    0 1;
    0 1;
    1 0;
    0 -1;
    1 -1;
    1 0];

% f-matrix
f = [81.1478;
    82.9108;
    82.9051;
    81.1465;
    -82.9362;
    -1.7709;
    81.1301
    ];