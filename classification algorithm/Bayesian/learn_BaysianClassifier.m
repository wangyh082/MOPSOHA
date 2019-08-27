function [priors mean_vectors cov_matrices] = learn_BaysianClassifier(trn_set, class_id, K)
%------------------------------ INPUT ------------------------------
% trn_set   : training Set => D X N Vectors
% class_id  : class id of each training set. Each Values have an Class ID 
%             of corresponding feature vector of training set => 1 X N
%   K       : Number of Classes
%------------------------------ OUTPUT ------------------------------
% priors        : prior probabilities for each class
%                 1 X K Array
% mean_vectors  : mean vectors for each class 
%                 D X K Vectors
% cov_matrices  : covariance matrices for each class
%                 D X D X K Covariance Matrices
% 
% 
% leejaejun, Koreatech, Korea Republic, 2014.12.09
% jaejun0201@gmail.com


[dim N] = size(trn_set);
mean_vectors = [];
cov_matrices = [];
priors = zeros(1,K);
for i=1:1:K
    trn_data = trn_set(:,class_id==i);
    priors(1,i) = size(trn_data,2) / N;
    [MU COV] = getGaussianParameters(trn_data);
    mean_vectors = cat(2,mean_vectors,MU);
    cov_matrices = cat(3,cov_matrices,COV);
end

