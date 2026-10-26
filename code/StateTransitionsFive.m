function P = StateTransitionsFive(p,M,T,N)

    K = 5; % Number of strategies
    num_states = nchoosek(N+4,4);
    [states, state_lookup] = GenerateStateSpace(N, K);

    P = sparse(num_states, num_states);

    num_states = size(states, 1);
    K = 5; % Number of strategies
    P = zeros(num_states, num_states);
    
    for i = 1:num_states
        s_current = states(i, :);
        s1 = s_current(1);
        s2 = s_current(2);
        s3 = s_current(3);
        s4 = s_current(4);
        s5 = s_current(5);
        
        % 1. Get payoffs for all 5 strategies
        % Assuming Q_matrix is updated to handle 5 inputs or a vector
        Q = Q_matrix_5(s1, s2, s3, s4, s5, p, M, T)'; 
        
        % 2. Calculate the Revision Protocol (rho)
        % rho(src, dest) is the prob. a player of type 'src' switches to 'dest'
        rho = zeros(K, K);
        for src = 1:K
            % Calculate surplus for all potential target strategies
            surplus = max(0, Q - Q(src)); 
            
            % Weight surplus by the fraction of the population in those strategies
            % This is a common "imitation" or "comparison" protocol
            weighted_surplus = (s_current / N) .* surplus;
            total_surplus = sum(weighted_surplus);
            
            if total_surplus > 0
                rho(src, :) = weighted_surplus / total_surplus;
            else
                rho(src, src) = 1; % Stay put if no better options
            end
        end
        
        % 3. Fill the Transition Matrix P
        % The probability of moving from state i to a state where one player switched
        for src = 1:K
            if s_current(src) > 0 % Only possible if someone is playing 'src'
                for dest = 1:K
                    % Probability of picking a 'src' player * prob they switch to 'dest'
                    prob_move = (s_current(src) / N) * rho(src, dest);
                    
                    if prob_move > 0
                        if src == dest
                            % Staying in the same state
                            P(i, i) = P(i, i) + prob_move;
                        else
                            % Define the new population distribution
                            new_s = s_current;
                            new_s(src) = new_s(src) - 1;
                            new_s(dest) = new_s(dest) + 1;
                            
                            % Use the lookup table to find the 2D matrix index
                            % Recall: state_lookup uses only the first 4 coordinates
                            target_idx = state_lookup(new_s(1)+1, new_s(2)+1, ...
                                                      new_s(3)+1, new_s(4)+1);
                            
                            P(i, target_idx) = prob_move;
                        end
                    end
                end
            end
        end
    end

    
end