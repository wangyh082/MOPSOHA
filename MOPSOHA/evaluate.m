function [featIxes,fval,labellabel] = evaluate(x,fea1,gnd,suRED,suREL,numberTrain)
    X = transfer2binaryNew(x);
    featIxes = find(X==1);
    nAttrs = size(X,2);
    cardinality = numel(featIxes);
    if cardinality == 0
        fval = [Inf Inf Inf numel(featIxes)]';
        results=zeros(10,1);
        indices = crossvalind('Kfold',numberTrain,10);
        for ii = 1:10
            test = (indices == ii); train = ~test;
            %                     position=find(test == 1);
            label=knn(fea1(train,featIxes), gnd(train), fea1(test,featIxes),2);
            results(ii)=Misclassification_error(gnd(test), label);
            labellabel(test)=label;
        end
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
        results=zeros(10,1);
        indices = crossvalind('Kfold',numberTrain,10);
        for ii = 1:10
            test = (indices == ii); train = ~test;
            %                     position=find(test == 1);
            label=knn(fea1(train,featIxes), gnd(train), fea1(test,featIxes), 2);
            results(ii) = Misclassification_error(gnd(test), label);
            labellabel(test)=label;
        end
%         labellabel
        ACC=sum(results)/10;
        Car=size(featIxes,2);
        fval = [-REL RED -ACC Car]';
    end
end
