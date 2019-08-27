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
        results=zeros(10,1);
        indices = crossvalind('Kfold',NP,10);
        for ii = 1:10
            test = (indices == ii); train = ~test;
            learning_rate = 0.1;%Ô­£º0.1
            goal_error_rate = 0.01;%Ô­£º0.01
            maximum_generation = 1000;
            mix_orderOfInputData = 1;
            N_hidden_node = 1000;
            [u v err_log] = learn_3_layer_neural_network(fea1(train)',numel(unique(gnd)),gnd(train)',N_hidden_node,learning_rate, goal_error_rate,maximum_generation,mix_orderOfInputData);
            label = classify_with_3_layer_neural_network(u,v,fea1(test)');
            results(ii)=Misclassification_error(gnd(test), label);
            labellabel(test)=label;
        end

        ACC=sum(results)/10;
        Car=size(featIxes,2);
        fval = [-REL RED -ACC Car];
end
