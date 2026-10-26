function [states, state_lookup] = GenerateStateSpace(N, K)
    % N: Total number of players
    % K: Number of strategies (fixed at 5 for this task)
    
    % The number of states is given by the stars and bars formula: 
    % nchoosek(N + K - 1, K - 1)
    num_states = nchoosek(N + 4, 4);
    
    % Initialize the states matrix: each row is [s1, s2, s3, s4, s5]
    states = zeros(num_states, K);
    
    % Initialize lookup table. Since counts can be 0, we use index (s+1).
    % Size is (N+1) in the first 4 dimensions. The 5th is redundant 
    % because s5 = N - s1 - s2 - s3 - s4.
    state_lookup = zeros(repmat(N + 1, 1, K - 1));
    
    idx = 0;
    
    % Nested loops to partition N into 5 strategies
    for s1 = 0:N
        for s2 = 0:(N - s1)
            for s3 = 0:(N - s1 - s2)
                for s4 = 0:(N - s1 - s2 - s3)
                    s5 = N - s1 - s2 - s3 - s4;
                    
                    idx = idx + 1;
                    states(idx, :) = [s1, s2, s3, s4, s5];
                    
                    % Map the population vector to the state ID (idx)
                    % We only need the first 4 coordinates to uniquely identify the state
                    state_lookup(s1+1, s2+1, s3+1, s4+1) = idx;
                end
            end
        end
    end
end