function q = Q_matrix(s1, s2, s3, p, M, T)


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

    q1 = (s1-1)*C11 + s2*C12 + s3*C13;
    q2 = s1*C21 + (s2-1)*C22 + s3*C23;
    q3 = s1*C31 + s2*C32 + (s3-1)*C33;

    q = [q1; q2; q3];

end