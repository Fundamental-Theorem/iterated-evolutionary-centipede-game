function s = MarkDynFive(s0,p,M,T,N,P,Tm)

    % Generate State Space
    [states, state_lookup] = GenerateStateSpace(N, 5);

    k = 1;
    reps = [];
    s1= [];
    s2= [];
    s3 = [];
    s4 = [];
    s5 = [];
   
    reps = [reps 0];
    s1 = [s1 s0(1)];
    s2 = [s2 s0(2)];
    s3 = [s3 s0(3)];
    s4 = [s4 s0(4)];
    s5 = [s5 s0(5)];
    
    % Start the clock 
    tic

    % Loop
    while toc < Tm

        n = state_lookup(s1(end)+1, s2(end)+1, s3(end)+1, s4(end)+1);
        r = rand;
        idx = find(P(n,:));

        % Stop earlier
        if length(idx) == 1
            disp('Stop to a Rest Point')
            break;
        end

        % Array of non-zero propabilities
        probs = zeros(length(idx));
        for i = 1: length(idx)
            probs(i) = P(n,idx(i)); 
        end
        
        c = cumsum(probs);  % [p1, p1 + p2, p1 + p2 + p3, ..., 1]
        index_of_probs = find(r <= c,1);
        u = idx(index_of_probs); % The number of node of the new state
    
        s_new =  states(u,:);

        s1 = [s1 s_new(1)];
        s2 = [s2, s_new(2)];
        s3 = [s3, s_new(3)];
        s4 = [s4, s_new(4)];
        s5 = [s5, s_new(5)];
        reps = [reps k];
        k = k+1;

    end

    s = [s1; s2; s3; s4; s5];

    figure(2)
    plot(reps , s1 , 'Color', 'b','LineWidth',2)
    hold on
    plot(reps,s2, 'Color','r','LineWidth',2)
    hold on 
    plot(reps, s3, 'Color','g','LineWidth',2)
    hold on
    plot(reps, s4, 'Color','y','LineWidth',2)
    hold on
    plot(reps, s5, 'Color','m','LineWidth',2)
    hold off
    legend('s1 => All-(M/2)','s2 => All-1','s3 => Grim', 's4 => Mod. Grim 1', 's5 => Mod. Grim 2')
    xlabel('Repetions of the loop')
    ylabel('Number of players of each strategy')
    ylim([-4,N+4]);
    grid on

end