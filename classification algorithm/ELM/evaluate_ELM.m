function [fval,labellabel] = evaluate_ELM(fea1,gnd)
global suRED suREL nFolds nELM nUnits NP
    [nPatterns,~] = size(fea1);
    classes  = unique(gnd);
    nClasses = numel(classes);
    Y = zeros(nPatterns,nClasses);
    for i = 1 : nClasses
        thisClass = classes(i);
        ixes = (gnd == thisClass);
        Y(ixes,i) = 1;
    end
    labellabel = ones(1,NP);
    nAttrs = size(fea1,2);
    featIxes = [1:nAttrs];
    cardinality = numel(featIxes);
    if cardinality == 0
        fval = [Inf Inf Inf numel(featIxes)];
    else
        REL = sum(suREL(featIxes));
        if cardinality == 1
            % 1 input selected, no redundancy
            RED = 0;
        else
            temp = nchoosek(featIxes,2);
            ixes = (temp(:,2)-1)*nAttrs+temp(:,1);
            RED = sum(suRED(ixes));
        end
        [ACC,label] = trainAndValidateELM(fea1,Y,featIxes,nFolds,nELM,nUnits);
        fval = [-REL RED -ACC cardinality];
        labellabel = label;
    end
end
