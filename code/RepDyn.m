function x = RepDyn(x0,p,M,T,Tf)

% M => Number of Centipede stages
% T => Number of one-shot centipedes played
% p => proportion of payoff received by terminating player
% Tf => final time of simulating replicator dynamics
% x0 => Vector of starting point


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


dt = 0.01;     
k=1;

reps = [];
x1 = [];
x2 = [];
x3 = [];

reps = [reps 0];
x1 = [x1 x0(1)];
x2 = [x2 x0(2)];
x3 = [x3 x0(3)];


% Real - Time figure

figure;
h = bar([x0(1) x0(2) x0(3)]);

h.FaceColor = 'flat';   % επιτρέπει διαφορετικό χρώμα ανά μπάρα
h.CData = [1 0 0;       % κόκκινο (x1)
           0 1 0;       % πράσινο (x2)
           0 0 1];      % μπλε (x3)

ylim([0 1])
xticklabels({'x1','x2','x3'})
title('Real-time evolution of strategies')
ylabel('Proportion')

drawnow



% Start the clock 
tic

while toc < Tf   % Tf must be seconds

    % Differential Equations
    dx1 = x1(end) .* (C11.*x1(end) + C12.*x2(end) + C13.*x3(end) - (C11*x1(end).^2 + (C12+C21)*x1(end).*x2(end) + (C13+C31)*x1(end).*x3(end) + C22*x2(end).^2 + (C23+C32)*x2(end).*x3(end) + C33*x3(end).^2));
    dx2 = x2(end) .* (C21.*x1(end) + C22.*x2(end) + C23.*x3(end)  - (C11*x1(end).^2 + (C12+C21)*x1(end).*x2(end) + (C13+C31)*x1(end).*x3(end) + C22*x2(end).^2 + (C23+C32)*x2(end).*x3(end) + C33*x3(end).^2));
    
    x1temp = x1(end) + dx1 *dt;
    x2temp = x2(end) + dx2*dt;
    x3temp = 1- x1temp - x2temp ;
    
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


    % Storing the values
    x1 = [x1 x1temp];
    x2 = [x2 x2temp];
    x3 = [x3 x3temp];
    reps = [reps k];
    k = k+1;


    % Update

    set(h, 'YData', [x1(end) x2(end) x3(end)]);
    drawnow;
    pause(0.01);


    %Stop earlier if we reach at a rest poinτ

    % Another way to go
    % if x1(end) == x1(end - 1)
        %break;
    %end

    if (x1(end) == 1 && x2(end) == 0 && x3(end) == 0) || ...
   (x1(end) == 0 && x2(end) == 1 && x3(end) == 0) || ...
   (x1(end) == 0 && x2(end) == 0 && x3(end) == 1)

    break;
    end


end 


figure;
plot(reps , x1 , 'Color', 'r','LineWidth',2)
hold on
plot(reps,x2, 'Color','g','LineWidth',2)
hold on 
plot(reps, x3, 'Color','b','LineWidth',2)
legend('x1 => All-(M/2)','x2 => All-1','x3 => Grim')
xlabel('Repetitions of the loop')
ylabel('Proportion of each strategy')
ylim([-0.4,1.4])
grid on



x = [x1; x2; x3];

end
