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

function P=SelectFromPopulation(pop,grid,beta)

    sg=grid([grid.N]>0);

    p=1./[sg.N].^beta;
    p=p/sum(p);

    k=RouletteWheelSelection(p);

    Members=sg(k).Members;

    i=Members(randi([1 numel(Members)]));
    
    P=pop(i);

end