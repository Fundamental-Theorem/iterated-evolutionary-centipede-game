function [x,y] = RepDyn2Pop(x0,y0,p,M,T,Tf)

    C11 = T*M;
    C12 = 3*T*(1-p);
    C13 = T*M;
    C21 = 3*T*p;
    C22 = T;
    C23 = 3*p+(T-1);
    C31 = T*M;
    C32 = 3*(1-p)+(T-1);
    C33 = T*M;

    dt = 0.01;     
    k=1;
    
    reps = [];
    x1 = [];
    x2 = [];
    x3 = [];
    y1 = [];
    y2 = [];
    y3 = [];

    reps = [reps 0];
    x1 = [x1 x0(1)];
    x2 = [x2 x0(2)];
    x3 = [x3 x0(3)];
    y1 = [y1 y0(1)];
    y2 = [y2 y0(2)];
    y3 = [y3 y0(3)];

    % Start clock
    tic;

    while toc < Tf   % Tf must be seconds

    % Differential Equations
    xCy = x1(end) * (C11*y1(end) + C12*y2(end) + C13*y3(end)) + x2(end) * (C21*y1(end) + C22*y2(end) + C23*y3(end)) + x3(end) * (C31*y1(end) + C32*y2(end) + C33*y3(end));
    dx1 = x1(end) * (C11*y1(end) + C12*y2(end) + C13*y3(end) - xCy);
    dx2 = x2(end) * (C21*y1(end) + C22*y2(end) + C23*y3(end) - xCy);
    dx3 = x3(end) * (C31*y1(end) + C32*y2(end) + C33*y3(end) - xCy);
    dy1 = y1(end) * (C11*x1(end) + C21*x2(end) + C31*x3(end) - xCy);
    dy2 = y2(end) * (C12*x1(end) + C22*x2(end) + C32*x3(end) - xCy);
    dy3 = y3(end) * (C13*x1(end) + C23*x2(end) + C33*x3(end) - xCy);
    
    x1temp = x1(end) + dx1*dt;
    x2temp = x2(end) + dx2*dt;
    x3temp = x3(end) + dx3*dt;
    y1temp = y1(end) + dy1*dt;
    y2temp = y2(end) + dy2*dt;
    y3temp = y3(end) + dy3*dt;
    
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
    
    % Is everything inside the triangle?
    x1temp = max(x1temp,0);
    x2temp = max(x2temp,0);
    x3temp = max(x3temp,0);
    y1temp = max(y1temp,0);
    y2temp = max(y2temp,0);
    y3temp = max(y3temp,0);


    % Storing the values
    x1 = [x1 x1temp];
    x2 = [x2 x2temp];
    x3 = [x3 x3temp];
    y1 = [y1 y1temp];
    y2 = [y2 y2temp];
    y3 = [y3 y3temp];
    reps = [reps k];
    k = k+1;

    % Stop earlier if we reach at a rest point
    if x1(end) == x1(end -1) && x2(end) == x2(end-1) && x3(end) == x3(end-1) && y1(end) == y1(end -1) && y2(end) == y2(end-1) && y3(end) == y3(end-1)
        break;
    end

    end 
    
    figure(1);

    subplot(2,1,1);
    plot(reps , x1 , 'Color', 'b', 'LineWidth', 2)
    hold on
    plot(reps,x2, 'Color','r', 'LineWidth', 2)
    hold on 
    plot(reps, x3, 'Color','g', 'LineWidth', 2)
    legend('x1 => All-M','x2 => All-1','x3 => Grim')
    ylabel('Proportion of each strategy for X')
    xlim([0 200])
    grid on;

    subplot(2,1,2);
    plot(reps , y1 , 'Color', 'b', 'LineWidth', 2)
    hold on
    plot(reps,y2, 'Color','r', 'LineWidth', 2)
    hold on 
    plot(reps, y3, 'Color','g', 'LineWidth', 2)
    legend('y1 => All-M','y2 => All-1','y3 => Grim')
    xlabel('Repetions of the loop')
    ylabel('Proportion of each strategy for Y')
    xlim([0 200])
    grid on;

    sgtitle("Two-Population Replicator Dynamics")
    
    y = [y1; y2; y3];
    x = [x1; x2; x3];

end