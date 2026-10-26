function PhasePlot(p, M, T)

    % Payoff matrix
    C11 = T*M/2;
    C12 = 3*T*(1-p);
    C13 = (M+1)*p + (T-1)*3*(1-p);
    C21 = 3*T*p;
    C22 = T;
    C23 = 3*p+(T-1);
    C31 = (M+1)*(1-p) + (T-1)*3*p;
    C32 = 3*(1-p)+(T-1);
    C33 = T*M;

    [x1,x2] = meshgrid(0:0.04:1,0:0.04:1);
    
    % Keep only points inside the x1+x2+x3=1 triangle
    mask = (x1 + x2 <= 1);
    x1 = x1(mask);
    x2 = x2(mask);
    x3 = 1 - x1 - x2;
    
    % Differential Equations
    dx1 = x1 .* (C11.*x1 + C12.*x2 + C13.*x3 - (C11*x1.^2 + (C12+C21)*x1.*x2 + (C13+C31)*x1.*x3 + C22*x2.^2 + (C23+C32)*x2.*x3 + C33*x3.^2));
    dx2 = x2 .* (C21.*x1 + C22.*x2 + C23.*x3  - (C11*x1.^2 + (C12+C21)*x1.*x2 + (C13+C31)*x1.*x3 + C22*x2.^2 + (C23+C32)*x2.*x3 + C33*x3.^2));
    
    % Compute magnitude of vectors
    mag = sqrt(dx1.^2 + dx2.^2);
    
    % Normalize vectors so all arrows have same length
    dx1n = dx1 ./ mag;
    dx2n = dx2 ./ mag;
    
    figure
    hold on
    
    % Draw triangle boundary
    v1 = [0 0]; v2 = [1 0]; v3 = [0 1]; % vertices
    plot([v1(1) v2(1) v3(1) v1(1)], ...
         [v1(2) v2(2) v3(2) v1(2)], ...
         'b','LineWidth', 2)
   
    % Phase plot
    quiver(x1,x2,dx1n,dx2n, 'Color', 'r');
    axis equal
    xlim([0 1])
    ylim([0 1])
    xlabel('x_1')
    ylabel('x_2')
    title("Phase Portrait for p = " + p);

end 