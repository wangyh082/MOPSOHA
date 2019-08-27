function result = BaysianClassifier(priors, mean_vectors, cov_matrices, data )
%------------------------------ INPUT ------------------------------
% priors        : prior probabilities for each class
%                 1 X K Array
% mean_vectors  : mean vectors for each class 
%                 D X K Vectors
% cov_matrices  : covariance matrices for each class
%                 D X D X K Covariance Matrices
% data          : data which we want to classify.
%                 D X N Vectors
%------------------------------ OUTPUT ------------------------------
% result        : Result array of classifying
%                 1 X N Array
% 
% 
% leejaejun, Koreatech, Korea Republic, 2014.12.09
% jaejun0201@gmail.com

[dim N] = size(data);
K = size(priors,2);

prob = zeros(K,N);

% get likelihood for every classes
for i=1:1:K
    prob(i,:) = getGaussianProbability(mean_vectors(:,i),cov_matrices(:,:,i),data);
end

prob = repmat(priors',1,N) .* prob;

[dummy result] = max(prob,[],1);

end

