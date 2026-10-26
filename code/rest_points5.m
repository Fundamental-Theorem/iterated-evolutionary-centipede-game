clc;
clear;

% Ορισμός συμβολικών μεταβλητών
syms x1 x2 x3 y1 y2 y3 T p M real


% Υποθέσεις για παραμέτρους
assume(T,{'positive','integer'});
assume(M,{'positive','integer'});
assume(p>(1/2) & p<1);



% Construct

C11 = T*M;
C12 = 3*(1-p)*T;
C13 = T*M;

C21 = 3*p*T;
C22 = T;
C23 = 3*p + (T-1);

C31 = T*M;
C32 = 3*(1-p) + (T-1);
C33 = T*M;


C = [C11, C12, C13; C21, C22, C23; C31, C32, C33];
% F = x^T*C*y 
F = x1*(C11*y1 + C12*y2 + C13*y3) + x2*(C21*y1 + C22*y2+ C23*y3) + x3*(C31*y1 + C32*y2 + C33*y3);

% for dx_m 

dx_1 = x1 * ( (C11*y1 + C12*y2 + C13*y3) - F );
dx_2 = x2 * ( (C21*y1 + C22*y2 + C23*y3) - F );
dx_3 = x3 * ( (C31*y1 + C32*y2 + C33*y3) - F );




% for dy_my2 


dy_1 = y1 * ( (C11*x1 + C21*x2 + C31*x3) - F );
dy_2 = y2 * ( (C12*x1 + C22*x2 + C32*x3) - F );
dy_3 = y3 * ( (C13*x1 + C23*x2 + C33*x3) - F );



% Λύση σημείων ισορροπίας
sol = solve([dx_1 == 0, dx_2 == 0, dx_3 == 0, dy_1 == 0, dy_2 == 0, dy_3 == 0], [x1, x2, x3, y1, y2, y3], ...
    'Real', true);


sol_matrix = [sol.x1, sol.x2, sol.x3, sol.y1, sol.y2, sol.y3];
simplified_matrix = simplify(sol_matrix);
unique_solutions = unique(simplified_matrix, 'rows');

% Εμφάνιση λύσεων
for i = 1:length(sol.x1)
    fprintf('Solution %d: \n' , i)
    disp('For x: ')
    disp([unique_solutions(i,1),unique_solutions(i,2),unique_solutions(i,3)])
    disp('For y: ')
    disp([ unique_solutions(i,4),unique_solutions(i,5),unique_solutions(i,6)])
    disp('====================================================================')
end


J = jacobian([dx_1; dx_2;dx_3;dy_1 ; dy_2; dy_3 ],[x1 x2 x3 y1 y2 y3]);


% Εμφάνιση όρων ιακοβιανού
for i = 1:6
    for j = 1:6
        fprintf('J%d%d = \n', i, j);
        disp(simplify(J(i,j)))
    end
end


n_eq = size(unique_solutions,1);

Jac_all = sym(zeros(6,6,n_eq));

for k = 1:n_eq

    % equilibrium point
    x1_eq = unique_solutions(k,1);
    x2_eq = unique_solutions(k,2);
    x3_eq = unique_solutions(k,3);
    y1_eq = unique_solutions(k,4);
    y2_eq = unique_solutions(k,5);
    y3_eq = unique_solutions(k,6);


    % symbolic Jacobian στο σημείο
    J_eq = simplify(subs(J,[x1 x2 x3 y1 y2 y3],[x1_eq x2_eq x3_eq y1_eq y2_eq y3_eq]));

    % αποθήκευση
    Jac_all(:,:,k) = J_eq;

    fprintf('\n=============================\n');
    fprintf('Equilibrium %d\n',k);

    fprintf('x1 = %s\n', char(x1_eq));
    fprintf('x2 = %s\n', char(x2_eq));
    fprintf('x3 = %s\n', char(x3_eq));
    fprintf('y1 = %s\n', char(y1_eq));
    fprintf('y2 = %s\n', char(y2_eq));
    fprintf('y3 = %s\n', char(y3_eq));

    fprintf('\nJacobian:\n');
    disp(J_eq)

    % symbolic eigenvalues
    lambda = simplify(eig(J_eq));

    fprintf('\nEigenvalues:\n');
    disp(lambda)


end
