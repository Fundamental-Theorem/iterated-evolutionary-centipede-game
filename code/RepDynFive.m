function x = RepDynFive(x0,p,M,T,Tf)

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

    dt = 0.01;
    k = 1;

    reps = [];
    x1 = [];
    x2 = [];
    x3 = [];
    x4 = [];
    x5 = [];

    reps = [reps 0];
    x1 = [x1 x0(1)];
    x2 = [x2 x0(2)];
    x3 = [x3 x0(3)];
    x4 = [x4 x0(4)];
    x5 = [x5 x0(5)];

    % Start the clock 
    tic

    while toc < Tf
        
        % Calculate Average Payoff
        B1 = x1(end)*C11 + x2(end)*C21 + x3(end)*C31 + x4(end)*C41 + x5(end)*C51;
        B2 = x1(end)*C12 + x2(end)*C22 + x3(end)*C32 + x4(end)*C42 + x5(end)*C52;
        B3 = x1(end)*C13 + x2(end)*C23 + x3(end)*C33 + x4(end)*C43 + x5(end)*C53;
        B4 = x1(end)*C14 + x2(end)*C24 + x3(end)*C34 + x4(end)*C44 + x5(end)*C54;
        B5 = x1(end)*C15 + x2(end)*C25 + x3(end)*C35 + x4(end)*C45 + x5(end)*C55;
        B = x1(end)*B1 + x2(end)*B2 + x3(end)*B3 + x4(end)*B4 + x5(end)*B5;

        % Calculate Derivatives
        dx1 = x1(end) .* (C11*x1(end) + C12*x2(end) + C13*x3(end) + C14*x4(end) + C15*x5(end) - B);
        dx2 = x2(end) .* (C21*x1(end) + C22*x2(end) + C23*x3(end) + C24*x4(end) + C25*x5(end) - B);
        dx3 = x3(end) .* (C31*x1(end) + C32*x2(end) + C33*x3(end) + C34*x4(end) + C35*x5(end) - B);
        dx4 = x4(end) .* (C41*x1(end) + C42*x2(end) + C43*x3(end) + C44*x4(end) + C45*x5(end) - B);

        x1temp = x1(end) + dx1*dt;
        x2temp = x2(end) + dx2*dt;
        x3temp = x3(end) + dx3*dt;
        x4temp = x4(end) + dx4*dt;
        x5temp = 1 - x1temp - x2temp - x3temp - x4temp;

        % Numerical cutoff 
        tol = 1e-4;
        if x1temp < tol
            x1temp = 0;
        end
        if x2temp < tol
            x2temp = 0;
        end
        if x3temp < tol
            x3temp = 0;
        end
        if x4temp < tol
            x4temp = 0;
        end 
        if x5temp < tol
            x5temp = 0;
        end

        % Keep everything inside the limits
        x1temp = max(x1temp,0);
        x2temp = max(x2temp,0);
        x3temp = max(x3temp,0);
        x4temp = max(x4temp,0);
        x5temp = max(x5temp,0);
        vec = [x1temp x2temp x3temp x4temp x5temp];

        % Normalize 
        vec = vec./sum(vec);
      

       
        % Storing values
        x1 = [x1 vec(1)];
        x2 = [x2 vec(2)];
        x3 = [x3 vec(3)];
        x4 = [x4 vec(4)];
        x5 = [x5 vec(5)];
        reps = [reps k];
        k = k + 1;

        % Stop earlier if we reach at a rest point
        if x1(end) == x1(end -1) && x2(end) == x2(end-1) && x3(end) == x3(end-1) && x4(end) == x4(end-1) && x5(end) == x5(end-1)
            break;
        end

    end

    figure(1);
    plot(reps , x1 , 'Color', 'g', 'LineWidth', 2)
    hold on
    plot(reps,x2, 'Color','r', 'LineWidth', 2)
    hold on 
    plot(reps, x3, 'Color','b', 'LineWidth', 2)
    hold on
    plot(reps, x4, 'Color','m', 'LineWidth', 2)
    hold on
    plot(reps, x5, 'Color','y', 'LineWidth', 2)
    legend('x1 => All-M','x2 => All-1','x3 => Grim', 'x4=> Mod. Grim 1', 'x5 => Mod. Grim 2')
    xlabel('Repetions of the loop')
    ylabel('Proportion of each strategy')
    grid on;
    
    
    x = [x1; x2; x3; x4; x5];

end