clc;
clear;


%%
% Assumptions for parameters
        syms x1 x2 x3 x4 x5 T p M log2M real
        assume(T,{'positive','integer'});
        assume(M,'integer');
        assumeAlso(M > 1);
        assumeAlso(log2M, 'integer')
        assume(p>(1/2) & p<1);

        % assumeAlso(x1 >= 0 & x1 <= 1);
        % assumeAlso(x2 >= 0 & x2 <= 1);
        % assumeAlso(x3 >= 0 & x3 <= 1);
        % assumeAlso(x4 >= 0 & x4 <= 1);
        % assumeAlso(x5 >= 0 & x5 <= 1);
         
        % eq_simplex = x1 + x2 + x3 + x4 + x5 == 1;




% Payoff Matrix
        C11 = T*M;  
        C12 = 3*T*(1-p); 
        C13 = T*M; 
        C14 = T*M; 
        C15 = T*M;

        C21 = 3*p*T; 
        C22 = T;
        C23 = 3*p+(T-1); 
        C24 = 3*p*log2M+(T-log2M);
        C25 = T*(3*p+1)/2;

        C31 = T*M;
        C32 = 3*(1-p) + (T-1);
        C33 = T*M;
        C34 = T*M;
        C35 = T*M;

        C41 = T*M;
        C42 = 3*(1-p)*log2M + (T-log2M);
        C43 = T*M;
        C44 = T*M;
        C45 = T*M;

        C51 = T*M;
        C52 = T*(4-3*p)/2;
        C53 = T*M;
        C54 = T*M;
        C55 = T*M;






% Calculate Average Payoff
        B1 = x1*C11 + x2*C21 + x3*C31 + x4*C41 + x5*C51;
        B2 = C21*x1 + C22*x2 + C23*x3 + C24*x4 + C25*x5;
        B3 = C31*x1 + C32*x2 + C33*x3 + C34*x4 + C35*x5;
        B4 = C41*x1 + C42*x2 + C43*x3 + C44*x4 + C45*x5;
        B5 = C51*x1 + C52*x2 + C53*x3 + C54*x4 + C55*x5;
        B = x1*B1 + x2*B2 + x3*B3 + x4*B4 + x5*B5;

        % Calculate Derivatives
        dx1 = x1 * (B1 - B);
        dx2 = x2 * (B2 - B);
        dx3 = x3 * (B3 - B);
        dx4 = x4 * (B4 - B);
        dx5 = x5 * (B5 - B);






% Calculating Rest Points


        sol = solve([dx1 == 0, dx2 == 0, dx3 == 0, dx4==0, dx5 ==0], [x1, x2, x3,x4,x5], ...
    'Real', true);




% 
% % Εμφάνιση λύσεων
% 
% fprintf('\n=================================================\n');
% fprintf('1) All the rest points\n');
% fprintf('=================================================\n');
% 
% for i = 1:length(sol.x1)
%     fprintf('Solution %d: \n' , i)
%     disp([sol.x1(i),sol.x2(i),sol.x3(i),sol.x4(i),sol.x5(i)])
% end
% 


sol_matrix = [sol.x1, sol.x2, sol.x3, sol.x4, sol.x5];
simplified_matrix = simplify(sol_matrix);
unique_solutions = unique(simplified_matrix, 'rows');


% 
% % Εμφάνιση λύσεων
% 
% fprintf('\n=================================================\n');
% fprintf('2) Rest points simplified\n');
% fprintf('=================================================\n');
% 
% for i = 1:length(unique_solutions)
%     fprintf('Solution %d: \n' , i)
%     disp([unique_solutions(i,:)])
% end


eq_sum_1 = [];

for i = 1:length(unique_solutions)
     sum = unique_solutions(i,1) + unique_solutions(i,2) + unique_solutions(i,3) + unique_solutions(i,4) + unique_solutions(i,5);
    if simplify(sum) == 1
        eq_sum_1 = [eq_sum_1 ; unique_solutions(i,1) , unique_solutions(i,2) , unique_solutions(i,3) , unique_solutions(i,4) , unique_solutions(i,5)];
    end
end


% Εμφάνιση αποδεκτών λύσεων

fprintf('\n=================================================\n');
fprintf('3) Accepted because the x1 + x2 + x3 + x4 + x5 = 1\n');
fprintf('=================================================\n');


for i = 1:length(eq_sum_1)
    fprintf('Solution %d: \n' , i)
    disp([eq_sum_1(i,:)])
end


accepted_eq = [
    eq_sum_1(1,:) ;
    eq_sum_1(2,:) ;
    %eq_sum_1(3,:) ;
    eq_sum_1(4,:) ;
    %eq_sum_1(5,:) ;
    %eq_sum_1(6,:) ;
    eq_sum_1(7,:) ;
    eq_sum_1(8,:) ;
    eq_sum_1(9,:) ;
    eq_sum_1(10,:) ;
    eq_sum_1(11,:) ;   
    eq_sum_1(12,:) ;
    %eq_sum_1(13,:) ;
    %eq_sum_1(14,:) ;
    %eq_sum_1(15,:) ;
];



%% Calculating Jacobian and Eigenvalues


J = jacobian([dx1;dx2;dx3;dx4;dx5],[x1 x2 x3 x4 x5]);


% % Εμφάνιση όρων ιακοβιανού
% for i = 1:5
%     for j = 1:5
%         fprintf('J%d%d = \n', i, j);
%         disp(simplify(J(i,j)))
%     end
% end

n_eq = size(accepted_eq,1);

Jac_all = sym(zeros(5,5,n_eq));

for k = 1:n_eq

    % equilibrium point
    x1_eq = accepted_eq(k,1);
    x2_eq = accepted_eq(k,2);
    x3_eq = accepted_eq(k,3);
    x4_eq = accepted_eq(k,4);
    x5_eq = accepted_eq(k,5);


    % symbolic Jacobian στο σημείο
    J_eq = simplify(subs(J,[x1 x2 x3 x4 x5],[x1_eq x2_eq x3_eq x4_eq x5_eq]));

    % αποθήκευση
    Jac_all(:,:,k) = J_eq;

    fprintf('\n=============================\n');
    fprintf('Equilibrium %d\n',k);

    fprintf('x1 = %s\n', char(x1_eq));
    fprintf('x2 = %s\n', char(x2_eq));
    fprintf('x3 = %s\n', char(x3_eq));
    fprintf('x4 = %s\n', char(x4_eq));
    fprintf('x5 = %s\n', char(x5_eq));

    fprintf('\nJacobian:\n');
    disp(J_eq)

    % symbolic eigenvalues
    lambda = simplify(eig(J_eq));

    fprintf('\nEigenvalues:\n');
    disp(lambda)


end


% 
% % 1. Ορίζουμε την οικογένεια σημείων (x2 = 0, και x5 = 1 - x1 - x3 - x4)
% J_family = subs(J, [x2, x5], [0, 1 - x1 - x3 - x4]);
% J_family = simplify(J_family);
% 
% % 2. Εμφανίζουμε τη 2η γραμμή για να επιβεβαιώσουμε ότι εκτός του J22, όλα είναι 0
% fprintf('\n=================================================\n');
% fprintf('Η 2η γραμμή του Ιακωβιανού για την οικογένεια S:\n');
% fprintf('=================================================\n');
% disp(J_family(2, :));
% 
% % 3. Απομονώνουμε την κρίσιμη ιδιοτιμή J22 (που αντιστοιχεί στο ε_2)
% lambda_2 = simplify(J_family(2, 2));
% fprintf('\n=================================================\n');
% fprintf('Η κρίσιμη ιδιοτιμή lambda_2 (εκφρασμένη μέσω των x1, x3, x4) είναι:\n');
% fprintf('=================================================\n');
% disp(lambda_2);
% 
% % 4. Ζητάμε όλες τις ιδιοτιμές
% % Επειδή ο πίνακας απλοποιείται πολύ, το MATLAB λογικά θα μπορέσει να τις βρει:
% eigenvalues_family = simplify(eig(J_family));
% fprintf('\n=================================================\n');
% fprintf('Όλες οι ιδιοτιμές της οικογένειας S:\n');
% fprintf('=================================================\n');
% disp(eigenvalues_family);