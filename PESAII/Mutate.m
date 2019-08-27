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

function y=Mutate(x,params)

    h=params.h;
    VarMin=params.VarMin;
    VarMax=params.VarMax;

    sigma=h*(VarMax-VarMin);
    
    y=x+sigma.*randn(size(x));
    
    % y=x+sigma*unifrnd(-1,1,size(x));
    
    y=min(max(y,VarMin),VarMax);

end