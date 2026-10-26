function n = state2node(s, N)  % s = [s1,s2, s3];

    start = 1;
    
    for i = 0:s(1)-1
        start = start + (N+1) - i;
    end

    finish = 0;
    
    for i = 0:s(1)
        finish = finish + (N+1) - i;
    end

    %sprintf('The node is between %d and %d',start, finish)
    
    n = start;

    for i = 1:s(2)
        n = n + 1;
    end

    %sprintf('The node is: %d' , n)
    

end