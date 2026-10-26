function P = StateTransitionGraph(p, M, T, N)

    num_states = (N+1)*(N+2)/2;

    % Coordinates of nodes in the simplex
    nodes = zeros(num_states, 2);

    % Recover each state from its node index
    for node = 1:num_states
        s = node2state(node, N);   % s = [s1 s2 s3]
        nodes(node, :) = [s(1), s(2)];
    end

    % Initialize Transition Matrix
    P = zeros(num_states, num_states);
    edges_start = [];
    edges_target = [];

    for i = 1:num_states
        s = node2state(i, N);
        s1 = s(1);
        s2 = s(2);
        s3 = s(3);

        % Strategy Payoff Vector Q
        Q = Q_matrix(s1, s2, s3, p, M, T);

        % Calculate Revision Protocol rho_ij
        rho = zeros(3, 3);
        for src = 1:3
            surplus = max(0, Q' - Q(src));      % [Qj - Qi]+
            weighted_surplus = (s / N) .* surplus;
            total_surplus = sum(weighted_surplus);

            if total_surplus > 0
                rho(src, :) = weighted_surplus / total_surplus;
            else
                rho(src, src) = 1;  % Stay if current strategy is best
            end
        end

        % Fill Transition Probabilities
        for src = 1:3
            if s(src) > 0   % Can't pick a player if none exist
                for dest = 1:3
                    prob_move = (s(src) / N) * rho(src, dest);

                    if src == dest
                        P(i, i) = P(i, i) + prob_move;
                    else
                        new_s = s;
                        new_s(src) = new_s(src) - 1;
                        new_s(dest) = new_s(dest) + 1;

                        target_idx = state2node(new_s, N);

                        P(i, target_idx) = prob_move;

                        if prob_move > 0
                            edges_start = [edges_start i];
                            edges_target = [edges_target target_idx];
                        end
                    end
                end
            end
        end
    end

    % --- Plotting Logic ---
    v1 = [N 0];
    v2 = [0 N];
    v3 = [0 0];

    figure;
    hold on;
    plot([v1(1) v2(1) v3(1) v1(1)], ...
         [v1(2) v2(2) v3(2) v1(2)], ...
         'w', 'LineWidth', 1);

    G = digraph(edges_start, edges_target, [], num_states);

    colors = color_nodes(P, N);
    p_graph = plot(G, 'XData', nodes(:,1), 'YData', nodes(:,2));
    p_graph.NodeLabel = [];
    p_graph.MarkerSize = 5;
    p_graph.NodeColor = colors;
    p_graph.EdgeColor = [0.3 0.3 0.3];
    p_graph.ArrowSize = 8;

    title("Directed State Transition Graph (N=" + N + ", p=" + p + ")");
end