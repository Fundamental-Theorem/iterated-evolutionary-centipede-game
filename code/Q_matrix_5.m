function Q = Q_matrix_5(s1, s2, s3, s4, s5, p, M, T)

    % Payoff Matrix
    C11 = T*M;  
    C12 = 3*T*(1-p); 
    C13 = T*M; 
    C14 = T*M; 
    C15 = T*M;

    C21 = 3*p*T; 
    C22 = T;
    C23 = 3*p+(T-1); 
    C24 = 3*p*log2(M)+(T-log2(M));
    C25 = T*(3*p+1)/2;

    C31 = T*M;
    C32 = 3*(1-p) + (T-1);
    C33 = T*M;
    C34 = T*M;
    C35 = T*M;

    C41 = T*M;
    C42 = 3*(1-p)*log2(M) + (T-log2(M));
    C43 = T*M;
    C44 = T*M;
    C45 = T*M;

    C51 = T*M;
    C52 = T*(4-3*p)/2;
    C53 = T*M;
    C54 = T*M;
    C55 = T*M;

    q1 = (s1-1)*C11 + s2*C12 + s3*C13 + s4*C14 + s5*C15;
    q2 = s1*C21 + (s2-1)*C22 + s3*C23 + s4*C24 + s5*C25;
    q3 = s1*C31 + s2*C32 + (s3-1)*C33 + s4*C34 + s5*C35;
    q4 = s1*C41 + s2*C42 + s3*C43 + (s4-1)*C44 + s5*C45;
    q5 = s1*C51 + s2*C52 + s3*C53 + s4*C54 + (s5-1)*C55;

    Q = [q1; q2; q3; q4; q5];

end