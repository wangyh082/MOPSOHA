%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YOEA122
% Project Title: Strength Pareto Evolutionary Algorithm 2 (SPEA2)
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function b=Dominates(x,y)

    if isstruct(x) && isfield(x,'Cost')
        x=x.Cost;
    end

    if isstruct(y) && isfield(y,'Cost')
        y=y.Cost;
    end

    b=all(x<=y) && any(x<y);
    
end