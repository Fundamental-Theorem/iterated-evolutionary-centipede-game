clc;
clear;

% Ορισμός συμβολικών μεταβλητών
syms x1 x2 x3 T p M real


% Υποθέσεις για παραμέτρους
assume(T,{'positive','integer'});
assume(M,{'positive','integer'});
assume(p>(1/2) & p<1);

% Κοινός όρος
F = (T*M/2)*x1^2 + 3*T*x1*x2 + (M+3*T-2)*x1*x3 + ...
    T*x2^2 + (2*T+1)*x2*x3 + T*M*x3^2;

% Σύστημα
eq1 = x1*((T*M/2)*x1 + 3*T*(1-p)*x2 + ...
    ((M+1)*p + 3*(T-1)*(1-p))*x3 - F);

eq2 = x2*(3*T*p*x1 + T*x2 + ...
    (3*p + (T-1))*x3 - F);

eq3 = x3*(((M+1)*(1-p) + 3*(T-1)*p)*x1 + ...
    (3*(1-p) + (T-1))*x2 + T*M*x3 - F);

% Λύση σημείων ισορροπίας
sol = solve([eq1 == 0, eq2 == 0, eq3 == 0], [x1, x2, x3], ...
    'Real', true);

% Εμφάνιση λύσεων
for i = 1:length(sol.x1)
    fprintf('Solution %d: \n' , i)
    disp([sol.x1(i),sol.x2(i),sol.x3(i)])
end



J = jacobian([eq1;eq2;eq3 ],[x1 x2 x3]);


% Εμφάνιση όρων ιακοβιανού
for i = 1:3
    for j = 1:3
        fprintf('J%d%d = \n', i, j);
        disp(simplify(J(i,j)))
    end
end


% Αποδεκτές λύσεις
accepted_eq = [
    sol.x1(2), sol.x2(2), sol.x3(2);
    sol.x1(3), sol.x2(3), sol.x3(3);
    sol.x1(4), sol.x2(4), sol.x3(4);
    sol.x1(5), sol.x2(5), sol.x3(5);
    %sol.x1(6), sol.x2(6), sol.x3(6);
    sol.x1(7), sol.x2(7), sol.x3(7); 
    sol.x1(8), sol.x2(8), sol.x3(8)
];

n_eq = size(accepted_eq,1);

Jac_all = sym(zeros(3,3,n_eq));

for k = 1:n_eq

    % equilibrium point
    x1_eq = accepted_eq(k,1);
    x2_eq = accepted_eq(k,2);
    x3_eq = accepted_eq(k,3);

    % symbolic Jacobian στο σημείο
    J_eq = simplify(subs(J,[x1 x2 x3],[x1_eq x2_eq x3_eq]));

    % αποθήκευση
    Jac_all(:,:,k) = J_eq;

    fprintf('\n=============================\n');
    fprintf('Equilibrium %d\n',k);

    fprintf('x1 = %s\n', char(x1_eq));
    fprintf('x2 = %s\n', char(x2_eq));
    fprintf('x3 = %s\n', char(x3_eq));

    fprintf('\nJacobian:\n');
    disp(J_eq)

    % symbolic eigenvalues
    lambda = simplify(eig(J_eq));

    fprintf('\nEigenvalues:\n');
    disp(lambda)


end


