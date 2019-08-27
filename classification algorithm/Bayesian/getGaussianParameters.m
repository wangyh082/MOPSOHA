function [ MU COVMAT] = getGaussianParameters( data )
% data : input data for calculating mean and covariance.
%        D X N vectors
% N is the number of feature vectors
% D is the dimensions of feature vectors
% 
% 
% leejaejun, Koreatech, Korea Republic, 2014.12.09
% jaejun0201@gmail.com

N = size(data,2);
sum_data = sum(data,2);
MU = sum_data / N;
data = data - repmat(MU,1,N);
COVMAT = data / (N-1) * data';

end

