function s = node2state(node, N)

    num_nodes = (N+1)*(N+2)/2; 

    if node > num_nodes
        sprintf('There are less states at the diagram than %d', node)
        return
    end
    
    for i = 0:N
        for j = 0:(N-i)
            k = N- i -j;
            state = [i,j,k];
            if state2node(state,N) == node
                s = state; 
                return
            end       
        end
    end

    %disp(s)

end