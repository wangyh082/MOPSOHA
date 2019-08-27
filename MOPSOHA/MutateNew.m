% Mutate Operator
% modified

function newParticle = MutateNew(pop, i, pm, VarMin, VarMax)

nVar = size(pop(i).Position, 2);

k = max(1, floor(rand * nVar));
po = zeros(1,k);
newParticle = pop(i).Position;
s = pop(i).Position;

for  j = 1: k
    
    po(j) = randi([1, nVar]);
    
    mutrange = (VarMax(po(j)) - VarMin(po(j))) * pm;
    
    lb = s(po(j)) - mutrange;
    ub = s(po(j)) + mutrange;
    
    if lb < VarMin(po(j)) 
        
        lb = VarMin(po(j));
        
    end
    
    if ub > VarMax(po(j))
        
        ub = VarMax(po(j));
        
    end
    
    newParticle(po(j)) = unifrnd(lb, ub);
    
end

end
