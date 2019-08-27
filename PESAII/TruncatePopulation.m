function [pop, grid]=TruncatePopulation(pop,grid,E,beta)

    ToBeDeleted=[];

    for e=1:E
        
        sg=grid([grid.N]>0);

        p=[sg.N].^beta;
        p=p/sum(p);

        k=RouletteWheelSelection(p);

        Members=sg(k).Members;

        i=Members(randi([1 numel(Members)]));

        Members(Members==i)=[];

        grid(sg(k).Index).Members=Members;
        grid(sg(k).Index).N=numel(Members);

        ToBeDeleted=[ToBeDeleted i]; %#ok
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


    end
    
    pop(ToBeDeleted)=[];
    
end