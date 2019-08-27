% 
% Copyright (c) 2016, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
% 
% Project Code: YPEA126
% Project Title: Non-dominated Sorting Genetic Algorithm III (NSGA-III)
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Implemented by: S. Mostapha Kalami Heris, PhD (member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
% 
% Base Reference Paper:
% K. Deb and H. Jain, "An Evolutionary Many-Objective Optimization Algorithm 
% Using Reference-Point-Based Nondominated Sorting Approach, Part I: Solving
% Problems With Box Constraints,"
% in IEEE Transactions on Evolutionary Computation,
% vol. 18, no. 4, pp. 577-601, Aug. 2014.
% 
% Reference Papaer URL: http://doi.org/10.1109/TEVC.2013.2281535
% 

function Zr = GenerateReferencePoints(M, p)

    Zr = GetFixedRowSumIntegerMatrix(M, p)' / p;

end

function A = GetFixedRowSumIntegerMatrix(M, RowSum)

    if M < 1
        error('M cannot be less than 1.');
    end
    
    if floor(M) ~= M
        error('M must be an integer.');
    end
    
    if M == 1
        A = RowSum;
        return;
    end

    A = [];
    for i = 0:RowSum
        B = GetFixedRowSumIntegerMatrix(M - 1, RowSum - i);
        A = [A; i*ones(size(B,1),1) B];
    end

end
