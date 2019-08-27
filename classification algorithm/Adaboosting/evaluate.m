function [fval,labellabel] = evaluate(fea1,gnd)
global suRED suREL NP;
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
        results=zeros(10,1);
        indices = crossvalind('Kfold',NP,8);
        for ii = 1:8
            test = (indices == ii); train = ~test;  
            verbose = false;
            classifier = AdaBoost_mult(two_level_decision_tree, verbose); % blank classifier
            nTree = 15;
            C = classifier.train(fea1(train,featIxes), gnd(train), [], nTree);
            label = C.predict(fea1(test,featIxes));
            results(ii)=Misclassification_error(gnd(test), label);
            labellabel(test)=label;
        end
        ACC=sum(results)/10;
        Car=size(featIxes,2);
        fval = [-REL RED -ACC Car];
end
