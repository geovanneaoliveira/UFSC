function [mst, cost] = prim(A, plot)
    [n,n] = size(A);
    intree = 1; nintree=1;
    k = 0;
    notintree = [2:n]'; nnotintree=n-1;
    while nintree < n
        mincost = Inf;
        for i=1:nintree
            for j=1:nnotintree
                ni = intree(i); nj= notintree(j);
                if A(ni,nj) < mincost && A(ni,nj)~=0,
                    mincost = A(ni,nj); ei = ni; ej = nj;
                end
            end
        end
        k = k + 1;
        mst(k,:) = [ei,ej];
        costs(k,1) = mincost;
        nintree = nintree+ 1;
        nnotintree = nnotintree-1;
        intree = [intree; ej];
        notintree = setdiff(notintree,ej);
        highlight(plot,ei,ej, 'EdgeColor','red');
    end
    cost = sum(costs);
end
