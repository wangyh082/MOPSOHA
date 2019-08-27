function [u v err_log] = learn_3_layer_neural_network(training_data, N_class, class_ID, N_hidden, learning_rate, error_rate, max_generation, mix_inputData)
%------------------------------ INPUT ------------------------------
% trainingData    : training Data Set.
%                   D X N
% class_ID        : class id of each training set. Each Values have an Class ID
%                   of corresponding feature vector of training set
%                   1 X N
% N_hidden        : number of hidden node excluding bias node.
% learning_rate   : static learning rate
% error_rate      : if error rate is smaller than error_rate,
%                   stop learning and return.
% max_generation  : maximum number of iteration for learning.
%------------------------------ OUTPUT ------------------------------
% u(i,j)    : weight from (i)th input node to (j)th hidden node
%             first row is corresponding to input bias weights
%             (D+1) x (N_hidden)
% v(j,k)    : weight from (j)th hidden node to (k)th output node
%             first row is corresponding to hidden bias weights
%             (N_hidden+1) x N_class
%
%
% leejaejun, Koreatech, Korea Republic, 2014.12.09
% jaejun0201@gmail.com

err_log = [0];
[dim N] = size(training_data);
N_input = dim;   % dim feature node
N_output = N_class;  % number of classes
x0 = 1;
z0 = 1;

%% initialize neural network
% create desired output vectors.
if mix_inputData==1
    [training_data class_ID] = mixTrainingData(training_data,class_ID);
end
desired_output = getDesiredOutput(training_data,class_ID,N_output);

% initialize weights with random values (-0.2,0.2)
u = rand(N_input+1,N_hidden)*0.4-0.2;     % N_input + input bias node
v = rand(N_hidden+1, N_output)*0.4-0.2;   % N_hidden + hidden bias node

%% learning loop
z_sum = zeros(1,N_hidden);
z = zeros(1,N_hidden);
output_sum = zeros(1,N_output);
output = zeros(1,N_output);

for gen=1:max_generation
    for i_sample = 1:N
        % forward calculation
        z_sum(1,:) = sum( repmat([x0; training_data(:,i_sample)],1,N_hidden) .* u , 1);
        z(1,:) = activationFunction(z_sum);
        
        output_sum(1,:) = sum(repmat([z0 z]',1,N_output) .* v, 1);
        output = activationFunction(output_sum);
        
        % error back-propagation
        delta = (desired_output(:,i_sample)' - output) .* activationFunctionDot(output_sum);
        d_v = learning_rate * repmat(delta,N_hidden+1,1) .* repmat([z0 z]',1,N_output);
        
        eta = activationFunctionDot(z_sum) .* sum(repmat(delta,N_hidden,1) .* v(2:(N_hidden+1),:), 2)';
        d_u = learning_rate * repmat(eta,N_input+1,1) .* repmat([x0; training_data(:,i_sample)],1,N_hidden);
        
        v = v + d_v;
        u = u + d_u;
    end
    
    % mix training data per every generations
    if mix_inputData==1
        [training_data class_ID] = mixTrainingData(training_data,class_ID);
        desired_output = getDesiredOutput(training_data,class_ID,N_output);
    end
    
    % evaluation
    mean_square_error = 0.0;
    for i_sample=1:N
        % forward calculation
        z_sum(1,:) = sum( repmat([x0; training_data(:,i_sample)],1,N_hidden) .* u , 1);
        z(1,:) = activationFunction(z_sum);
        
        output_sum(1,:) = sum(repmat([z0 z]',1,N_output) .* v, 1);
        output = activationFunction(output_sum);
        
        mean_square_error = mean_square_error + 0.5*sum((desired_output(:,i_sample)-output').*(desired_output(:,i_sample)-output'),1);
    end
    mean_square_error = mean_square_error / N;
    err_log(1,gen) = mean_square_error;
    if gen > 11
        move_average = (gen-10):gen;
        err_change = abs(err_log(1,move_average)-err_log(1,move_average-1));
        if mean(err_change) < error_rate
            break;
        end
    end
end
% plot(1:length(err_log),err_log)
fprintf('Learning Complete at %dth generation\n',gen)
end

function [mixedTrainingData mixedClassID] = mixTrainingData(trainingData, classID)
[dim N] = size(trainingData);
trainingData = cat(1,classID,trainingData);
trainingData = trainingData(:,randperm(N));
mixedClassID = trainingData(1,:);
mixedTrainingData = trainingData(2:(dim+1),:);
end

function desiredOutput = getDesiredOutput(trainindData, classID, N_output)
[dim N] = size(trainindData);
desiredOutput = zeros(N_output,N);
for i=1:N
    desiredOutput(classID(1,i),i) = 1;
end
end