function [ scaledcar] = scaling( carMat,lowvec,upvec )    
%�������ݹ淶��    
%���ǽ�ͬһ�������еĲ�ͬά�ȹ�һ��  
%��Ϊ��Ϊ���ڲ�ͬ�����ԣ��������һ���ǲ����бȽ��Եģ����߲���һ��������  
%���롪��carMat��Ҫ���й淶����ͼ�����ݣ�    
%                lowvecԭ��ͼ�������е���Сֵ    
%                upvecԭ��ͼ�������е����ֵ    
upnew=1;    
lownew=-1;    
[m,n]=size(carMat);    
scaledcar=zeros(m,n);    
for i=1:m    
    scaledcar(i,:)=lownew+(carMat(i,:)-lowvec)./(upvec-lowvec)*(upnew-lownew);    
    %��ͼ��������һ�������Ĳ�ͬά�ȵ�ֵ����Сֵ�����ֵ�淶��-1��1������ֵ�������淶����-1,1��  
end    
end   
