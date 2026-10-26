function colors = color_nodes(P, N)

    PP = P^1000;
    b = PP(:, 1);
    g = PP(:, N+1);
    r = PP(:, (N+1)*(N+2)/2);
    colors = [r, g, b];
    m = max(colors, [], 'all');
    colors = colors / m; % Normalize colors to the range [0, 1]

end
