function [ micro, macro ] = micro_macro_PR( pred_label , orig_label)

mat=confusionmat(orig_label, pred_label);
len=size(mat,1);
macroTP=zeros(len,1);
macroFP=zeros(len,1);
macroFN=zeros(len,1);
macroP=zeros(len,1);
macroR=zeros(len,1);
macroF=zeros(len,1);
for i=1:len
    macroTP(i)=mat(i,i);
    macroFP(i)=sum(mat(:, i))-mat(i,i);
    macroFN(i)=sum(mat(i,:))-mat(i,i);
    macroP(i)=macroTP(i)/(macroTP(i)+macroFP(i));
    if (isnan(macroP(i)) == 1)
        macroP(i) = 0;
    end
    macroR(i)=macroTP(i)/(macroTP(i)+macroFN(i));
    if (isnan(macroR(i)) == 1)
        macroR(i) = 0;
    end
    macroF(i)=2*macroP(i)*macroR(i)/(macroP(i)+macroR(i));
    if (isnan(macroF(i)) == 1)
        macroF(i) = 0;
    end
end

macro.precision=mean(macroP);
macro.recall=mean(macroR);
macro.fscore=mean(macroF);

micro.precision=sum(macroTP)/(sum(macroTP)+sum(macroFP));
micro.recall=sum(macroTP)/(sum(macroTP)+sum(macroFN));
micro.fscore=2*micro.precision*micro.recall/(micro.precision+micro.recall);
end