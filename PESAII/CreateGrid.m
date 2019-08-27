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

function [pop, grid]=CreateGrid(pop,nGrid,InflationFactor)

    z=[pop.Cost]';
    
    zmin=min(z);
    zmax=max(z);
    
    dz=zmax-zmin;
    alpha=InflationFactor/2;
    zmin=zmin-alpha*dz;
    zmax=zmax+alpha*dz;
    
    nObj=numel(zmin);
    
    C=zeros(nObj,nGrid+3);
    for j=1:nObj
        C(j,:)=[-inf linspace(zmin(j),zmax(j),nGrid+1) inf];
    end
    
    empty_grid.LB=[];
    empty_grid.UB=[];
    empty_grid.Index=[];
    empty_grid.SubIndex=[];
    empty_grid.N=0;
    empty_grid.Members=[];
    
    nG=(nGrid+2)^nObj;
    
    GridSize=(nGrid+2)*ones(1,nObj);
    
    grid=repmat(empty_grid,nG,1);
    for k=1:nG
        SubIndex=cell(1,nObj);
        [SubIndex{:}]=ind2sub(GridSize,k);
        SubIndex=cell2mat(SubIndex);

        grid(k).Index=k;
        grid(k).SubIndex=SubIndex;
        
        grid(k).LB=zeros(nObj,1);
        grid(k).UB=zeros(nObj,1);
        for j=1:nObj
            grid(k).LB(j)=C(j,SubIndex(j));
            grid(k).UB(j)=C(j,SubIndex(j)+1);
        end
        
    end

    [pop, grid]=FindPositionInGrid(pop,grid);
    
end