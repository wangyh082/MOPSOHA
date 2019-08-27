function prob = getGaussianProbability(Mu, Sigma, Data)
%------------------------------ INPUT ------------------------------
% Data  : D X N Feature Vectors
% Mu    : D X 1 Mean Vector
% Sigma : D X D Covariance Matrix
%------------------------------ OUTPUT ------------------------------
% prob  : probabilities of [Data] given Gaussian of Mu,Sigma.
%         1XN Array
% 
% 
% leejaejun, Koreatech, Korea Republic, 2014.12.09
% jaejun0201@gmail.com

%% 
% [dim, n_data] = size(Data);
% Data = Data' - repmat(Mu',n_data,1);
% prob = diag(Data * inv(Sigma) * Data');
% prob = exp(-0.5*prob) / sqrt((2*pi)^dim * (abs(det(Sigma))+realmin));
% prob = prob';

%% from Sylvain Calinon, 2009
[dim, n_data] = size(Data);
Data = Data' - repmat(Mu',n_data,1);
prob = sum((Data*inv(Sigma)).*Data,2);
prob = exp(-0.5*prob) / sqrt((2*pi)^dim * (abs(det(Sigma))+realmin));
prob = prob';

end

