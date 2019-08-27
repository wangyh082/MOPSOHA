function k=FindGridIndex(z,LB,UB)

    nObj=numel(z);
    
    nGrid=size(LB,2);
    f=true(1,nGrid);
    
    for j=1:nObj
        f=f & (z(j)>=LB(j,:)) & (z(j)<UB(j,:));
    end
    
    k=find(f);

end