function[Error] =  Misclassification_error(test_labels, test_Predicted_labels)
%% this is the matlab Implementation for KNN misclassification error
% if you have labels for your test data set
% use KNN.m to find the predicted labels for test samples.
% then you can use this function to find misclassification error for your 
% test data set
% Input arguments: 
% test_labels : Known labels of your test data
% test_predicted_labels : predicted test labels

if(nargin < 2)
error('Incorrect number of inputs.');
end

% check if the input labels are in row vector
% if yes make it column vectors
if(isrow(test_labels)==1)
    test_labels = test_labels';
end

if(isrow(test_Predicted_labels)==1)
    test_Predicted_labels = test_Predicted_labels';
end

% matrix dimensions should be equal
[Ltest,~] = size(test_labels);
if (Ltest ~= size(test_Predicted_labels,1))
Error('matrix dimensions are not consistent');
end


count=0;

for i=1:Ltest   
if(test_labels(i,1)==test_Predicted_labels(i,1))
    count = count+1;
end    
end

missPredictions = count;
Error = missPredictions / Ltest;

end