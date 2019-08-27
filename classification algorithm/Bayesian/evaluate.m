function [fval,labellabel] = evaluate(fea1,gnd)
global suRED suREL NP
    nAttrs = size(fea1,2);
    featIxes = [1:nAttrs];
    cardinality = numel(featIxes);
        REL = sum(suREL(featIxes));
        if cardinality == 1
            % 1 input selected, no redundancy
            RED = 0;
        else
            temp = nchoosek(featIxes,2);
            ixes = (temp(:,2)-1)*nAttrs+temp(:,1);
            RED = sum(suRED(ixes));
        end
        results= zeros(10,1);
        indices = crossvalind('Kfold',NP,10);
        for ii = 1:10
            test = (indices == ii); train = ~test;
            [priors,mean_vectors,cov_matrices] = learn_BaysianClassifier(fea1(train)',gnd(train)',numel(unique(gnd)));
            label = BaysianClassifier(priors,mean_vectors,cov_matrices,fea1(test)');
            results(ii)=Misclassification_error(gnd(test), label');
            labellabel(test)=label;        
        end
        
        ACC=sum(results)/10;
        Car=size(featIxes,2);
        fval = [-REL RED -ACC Car];
end
