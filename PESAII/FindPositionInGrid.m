%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA123
% Project Title: Pareto Envelope-based Selection Algorithm II (PESA-II)
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function [pop, grid]=FindPositionInGrid(pop,grid)

    LB=[grid.LB];
    UB=[grid.UB];
    
%     grid
%     
    for k=1:numel(grid)
        grid(k).N=0;
        grid(k).Memebrs=[];
    end
    
%     numel(pop)
    for i=1:numel(pop)
        k=FindGridIndex(pop(i).Cost,LB,UB);
        pop(i).GridIndex=k;
        if numel(k) == 0
            continue;
        end
%         grid(k).N
        grid(k).N=grid(k).N+1;
        grid(k).Members=[grid(k).Members i];
    end

end
