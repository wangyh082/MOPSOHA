function stringResult = transfer2binaryNew(X)
stringResult = zeros(size(X));
row = size(X,1);
column = size(X,2);
a = normrnd(0.5, 0.1, 1, 1);

for i = 1:row
    for j = 1:column
%         
%         if rand > 0.9
%             s=1/(1+exp(-2*X(i,j)));
%             if a<s
%                 stringResult(i,j)=1;
%             else
%                 stringResult(i,j)=0;
%             end     
%         else 
%             s=abs(tanh(X(i,j)));
%         if type==1
%             s=1/(1+exp(-2*X(i,j))); %S1 transfer function
%         end
%         if type==2
%             s=1/(1+exp(-X(i,j)));   %S2 transfer function
%         end
%         if type==3
%             s=1/(1+exp(-X(i,j)/2)); %S3 transfer function
%         end
%         if type==4
%             s=1/(1+exp(-X(i,j)/3));  %S4 transfer function
%         end
%         if type==5
%             s=abs(erf(((sqrt(pi)/2)*X(i,j)))); %V1 transfer function
%         end
%         if type==6
%             s=abs(tanh(X(i,j))); %V2 transfer function
%         end
%         if type==7
%             s=abs(X(i,j)/sqrt((1+X(i,j)^2))); %V3 transfer function
%         end
%         if type==8
%             s=abs((2/pi)*atan((pi/2)*X(i,j))); %V4 transfer function (VPSO)
%         end
            s = abs((2/pi)*atan((pi/2)*X(i,j)));
            if a < s %Equation (10)
                stringResult(i,j)=0;
            else
                stringResult(i,j)=1;
            end
%         end
        
    end
end
end