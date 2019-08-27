function Offspring = get_a_cuckoo(s,MatingPool)

% [N,D] = size(MatingPool);

beta=1;

sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);

u=randn(size(s))*sigma;
v=randn(size(s));
step=u./abs(v).^(1/beta);

stepsize=0.1*step.* (MatingPool(1,:)-MatingPool(2,:));

s = s + stepsize.*randn(size(s));

MaxValue = 4*ones(size(s));
MinValue = -4*ones(size(s));

% MaxValue = ones(size(s));
% MinValue = zeros(size(s));

index1=find(s>MaxValue == 1);
s(index1) = max(2*MaxValue(index1) - s(index1),MinValue(index1));

index2=find(s<MinValue == 1);
s(index2) = min(2*MinValue(index2) - s(index2),MaxValue(index2));

Offspring = s;
end