function norm_data = normalizeData(data)
% This function normalize data between -1 and +1

nObs = size(data,1);

% get max and mins
maxs = repmat(max(data),[nObs,1]);
mins = repmat(min(data),[nObs,1]);

% normalize
norm_data = 2*((data-mins)./(maxs-mins+0.000000000001))-1;

