function [RED,REL] = computeRelevanceRedundancy(data,gnd)

PHI = data(:,1:end);
Y   = gnd;

% initialize outputs
nInputs = size(PHI,2);
RED = zeros(nInputs);
REL = zeros(nInputs,1);


hOut = entropy(Y);
for i = 1 : nInputs
    % compute RED
    hX = entropy(PHI(:,i));
    for j = i+1 : nInputs
        hY  = entropy(PHI(:,j));
        hXY = jointentropy(PHI(:,i), PHI(:,j));
        MI = hX+hY-hXY;
        SU = 2*MI/(hX+hY);
        RED(i,j) = SU;
    end
    % compute REL
    hY = hOut;
    hXY = jointentropy(PHI(:,i), Y);
    MI = hX+hY-hXY;
    SU = 2*MI/(hX+hY);
    REL(i) = SU;
end

% compute max values and scale everything
maxRED = sum(sum(RED(:)));
maxREL = sum(REL(:));
RED = RED/maxRED;
REL = REL/maxREL;

