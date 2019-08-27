function pop=DetermineDomination(pop)

    n=numel(pop);

    for i=1:n
        pop(i).IsDominated=false;
    end

    for i=1:n
        if pop(i).IsDominated
            continue;
        end
        
        for j=1:n
            if Dominates(pop(j),pop(i))
                pop(i).IsDominated=true;
                break;
            end
        end
    end

end