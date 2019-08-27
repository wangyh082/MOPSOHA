function rep = DeleteOneRepMember(rep, Extra)

    distance = [rep.Distance];
    [sorted, index] = sort(distance(1, :));
    [index] = index(1: Extra);
    [delete, index] = sort(index);
    for i = 1:Extra
        rep(delete(Extra - i + 1)) = [];
    end

end
