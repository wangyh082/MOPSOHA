function stringResult = transfer2binaryNew(X)
stringResult = zeros(size(X));
row = size(X,1);
column = size(X,2);
a = normrnd(0.5, 0.1, 1, 1);

for i = 1:row
    for j = 1:column
        
            s = abs((2/pi)*atan((pi/2)*X(i,j)));
            if a < s %Equation (10)
                stringResult(i,j)=0;
            else
                stringResult(i,j)=1;
            end
        
    end
end
end