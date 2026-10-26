function s = MarkDyn(s0,p,M,T,N,P,Tm)


% M => Number of Centipede stages
% T => Number of one-shot centipedes played
% p => proportion of payoff received by terminating player
% N => population size
% Tm => final time of simulating Markov dynamics
% s0 => initial Markov state
% P => Matrix that indicates the propability of changing a strategy 


k = 1;
reps = [];
s1= [];
s2= [];
s3 = [];


reps = [reps 0];
s1 = [s1 s0(1)];
s2 = [s2 s0(2)];
s3 = [s3 s0(3)];




% Start the clock 
tic

while toc < Tm   % Tf must be seconds
    n = state2node([s1(end),s2(end),s3(end)] , N);
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

    node = idx(index_of_probs); % The number of node of the new state

    s_new =  node2state(node,N);

    s1 = [s1 s_new(1)];
    s2 = [s2 s_new(2)];
    s3 = [s3 s_new(3)];
    reps = [reps k];
    k = k + 1;

   
        

end

s = [s1; s2; s3];


figure;
plot(reps , s1 , 'Color', 'r','LineWidth',2)
hold on
plot(reps,s2, 'Color','g','LineWidth',2)
hold on 
plot(reps, s3, 'Color','b','LineWidth',2)
legend('s1 => All-(M/2)','s2 => All-1','s3 => Grim')
xlabel('Repetitions of the loop')
ylabel('Number of players of each strategy')
ylim([-4,N+4]);
grid on


end