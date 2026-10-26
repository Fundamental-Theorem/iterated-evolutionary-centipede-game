clear; close all; clc; 

syms T M p a b c d 


% Payoff matrix elements
C11 = T*M/2;
C12 = 3*T*(1-p);
C13 = (M+1)*p + (T-1)*3*(1-p);
C21 = 3*T*p;
C22 = T;
C23 = 3*p+(T-1);
C31 = (M+1)*(1-p) + (T-1)*3*p;
C32 = 3*(1-p)+(T-1);
C33 = T*M;

% Construct the payoff matrix
C = [C11, C12, C13; C21, C22, C23; C31, C32, C33];

%x_hat = [(6*p-4)/(M-4) (M-6*p)/(M-4) 0];
x_hat = [1 0 0];
x = [a b 1-a-b];

Q1 = x_hat*C*x_hat';
Q2 = x*C*x_hat';
Q3 = x_hat*C*x';
Q4 = x*C*x';
