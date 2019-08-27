function result = classify_with_3_layer_neural_network( u, v, x )
%------------------------------ INPUT ------------------------------
% u(i,j)    : weight from (i)th input node to (j)th hidden node
%             first row is corresponding to input bias weights
%             (D+1) x (N_hidden)
% v(j,k)    : weight from (j)th hidden node to (k)th output node
%             first row is corresponding to hidden bias weights
%             (N_hidden+1) x N_class
% x         : input vectors to be classified
%             D x N
%------------------------------ OUTPUT ------------------------------
% result        : Result array of classifying data
%                 1 X N Array
%
%
% leejaejun, Koreatech, Korea Republic, 2014.12.09
% jaejun0201@gmail.com

[dim N] = size(x);
N_hidden = size(u,2);
N_output = size(v,2);
result = zeros(1,N);
for i_sample = 1:N
    z_sum = sum( repmat([1; x(:,i_sample)],1,N_hidden) .* u , 1);
    z = activationFunction(z_sum);
    
    output_sum = sum(repmat([1 z]',1,N_output) .* v, 1);
    output = activationFunction(output_sum);
    [val idx] = max(output);
    result(1,i_sample) = idx;
end
end

