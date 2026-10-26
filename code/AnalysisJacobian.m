clear; close all; clc;

% 1. Define symbolic variables
syms x1 x2 x3 M T p real
%x_hat = [0, 0, 1];
x_hat = [(6*p-4)/(M-4), (M-6*p)/(M-4), 0];

% 2. Define payoff matrix entries
C11 = T*M/2;
C12 = 3*T*(1-p);
C13 = (M+1)*p + (T-1)*3*(1-p);

C21 = 3*T*p;
C22 = T;
C23 = 3*p + (T-1);

C31 = (M+1)*(1-p) + (T-1)*3*p;
C32 = 3*(1-p) + (T-1);
C33 = T*M;

% 3. Average payoff (phi)
phi = C11*x1^2 + (C12+C21)*x1*x2 + (C13+C31)*x1*x3 + ...
      C22*x2^2 + (C23+C32)*x2*x3 + C33*x3^2;

% 4. Define system (replicator equations)
f1 = x1 * (C11*x1 + C12*x2 + C13*x3 - phi);
f2 = x2 * (C21*x1 + C22*x2 + C23*x3 - phi);
f3 = x3 * (C31*x1 + C23*x2 + C33*x3 - phi);

F = [f1; f2; f3];

% 5. Compute Jacobian
J = jacobian(F, [x1, x2, x3]);

% 6. Substitute and calculate eigenvalues
J_eq = subs(J, [x1, x2, x3], x_hat);
eigvals = eig(J_eq);