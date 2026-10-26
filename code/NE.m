clc;
clear;


% Ορισμός συμβολικών μεταβλητών
syms x1 x2 x3 T p M c a  real


% Υποθέσεις για παραμέτρους
assume(T,{'positive','integer'});
assume(M,{'positive','integer'});
assume(p>(1/2) & p<1);



% % For ( (a,1-a, 0), (c,1-c, 0) )
% eq1 = (T*M*c)/2 + (1-c)*3*T*(1-p) - 3*T*c*p - T*(1-c);
% eq2 = (T*M*a)/2 + (1-a)*3*T*(1-p) - 3*T*a*p - T*(1-a);
% 
% 
% sol1= solve([eq1 ==0, eq2==0], [a, c],'Real', true)


% % For ( (0,a, 1-a), (0,c, 1-c) )
% eq3 = T*c + (3*p +(T-1))*(1-c) - T*M*(1-c) - c*(3*(1-p) +(T-1));
% eq4 = T*a + (3*p +(T-1))*(1-a) - T*M*(1-a) - a*(3*(1-p) +(T-1));
% 
% sol2= solve([eq3 ==0, eq4==0], [a, c],'Real', true)
% 


% % For ( (a,0, 1-a), (c,0, 1-c))
% eq5 = (c*T*M)/2 + (1-c)*((M+1)*p +3*(T-1) *(1-p))- (1-c)*T*M - c*((M+1)*(1-p) + (T-1)*3*p);
% eq6 = (a*T*M)/2 + (1-a)*((M+1)*p +3*(T-1) *(1-p))- (1-a)*T*M - a*((M+1)*(1-p) + (T-1)*3*p);
% 
% 
% sol3= solve([eq5 ==0, eq6==0], [a, c],'Real', true)