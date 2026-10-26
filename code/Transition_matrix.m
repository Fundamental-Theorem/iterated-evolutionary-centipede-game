clc;
clear;
close all;


syms s1 s2 T M p N


% Υποθέσεις για παραμέτρους
assume(T,{'positive','integer'});
assumeAlso(M,{'positive','integer'});
assumeAlso(N,{'positive','integer'});
assumeAlso(p>(1/2) & p<1);
assumeAlso(s1,{'positive','integer'});
assumeAlso(s2,{'positive','integer'});
assumeAlso(s1 + s2 <= N);

s3 = N - s1 - s2;



Q = [
    (T*M/2)*(s1 - 1) + 3*T*(1 - p)*s2 + ((M + 1)*p + (T - 1)*3*(1 - p))*s3;
    
    3*T*p*s1 + T*(s2 - 1) + (3*p + (T - 1))*s3;
    
    ((M + 1)*(1 - p) + (T - 1)*3*p)*s1 + ...
    (3*(1 - p) + (T - 1))*s2 + ...
    T*M*(s3 - 1)
];


R = sym(zeros(3,3));

for i = 1:3
    for j = 1:3
        if i ~= j
           R(i,j) = piecewise(Q(j) > Q(i), Q(j)-Q(i), 0);
        end
    end
end

for i = 1:3
    others = Q([1:i-1, i+1:3]);
    R(i,i) = piecewise(max(others) > Q(i), 0, 1);
end

for i = 1:3
    for j = 1:3
        fprintf('\nR(%d,%d) =\n', i, j);
        disp(R(i,j));
    end
end

%Θεωρώ ότι οι εσωτερικές μεταβάσεις είναι όλες θετικές κάτι που είναι 
%αδύνατο, απλώς και μόνο για να πάρω τις αναλυτικές εκφράσεις της κάθε μετάβασης.
% Μετά απαλήφοντας του όρους όπου είναι ανεξάρτητοι ως προς Τ θα αποδείξουμε το πρόσημο.   
D = sym(zeros(3,3));


for i = 1:3
    for j = 1:3
        if i ~= j
           D(i,j) = simplify(Q(j) - Q(i));
        end
    end
end


for i = 1:3
    for j = 1:3
        if 1 ~= j
            fprintf('\nD(%d,%d) =\n', i, j);
            disp(D(i,j));
        end
    end
end


