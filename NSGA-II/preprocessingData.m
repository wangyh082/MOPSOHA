function result = preprocessingData(data)
x=data.fea;
y=data.gnd;
%%aim for new data
% y = y + 1;

dim=size(x,2);
if dim>200
    [features,~] = MI(x,y,12);
    result=[x(:,features(1:200)),y];
else
    result=[x,y];
end