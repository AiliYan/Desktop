function [f_matrix,realclass]=ReadPIC(n_classes,n_pic,flag)  
%MSTAR�⡣JPG��ʽ��ͼƬ��n_classes��Ŀ�꣬ѵ���Ͳ��Ը�ѡ��n_pic��ͼ��ͼ���СΪ128*128���ء�  
%3��Ŀ�꣬n_pic������ѵ����������trainingĿ¼�£�n_pic���������Լ�������testingĿ¼��
%  
%�������flag:  
%   flag��һ����ʶ����  
%   ��flagΪ0ʱ����ʾ����Ϊѵ������flagΪ1ʱ����ʾ����Ϊ���Լ�  
%  
%�������n_classes��  
%   n_classes��־������Ҫʶ���SARͼ��Ŀ�������
%  
%�������realclass��  
%   realclass��һ��n_classes*n_pic�У�1�е���������  
%   realclass�������ݵı�ǩ������ѵ�������Լ��������˱�ǩ����  
%  
%�������f_matrix:  
%   f_matrix��һ��n_classes*n_pic�У�128*128�еľ���  
%   ÿһ�б���ÿһ��ͼƬ�ĻҶ�����  
%   ��ÿһ��ͼƬ�������ų�һ����������ת�õõ�����f_matrix���е���  
  
imgrow=128;imgcol=128;  
global imgrow;   %����ͼƬ����  
global imgcol;    %����ͼƬ����  
realclass=zeros(n_classes*n_pic,1);  
f_matrix=zeros(n_classes*n_pic,imgrow*imgcol);  
for i=1:n_classes  
    %·������  
    %����num2str(i)˵����������ת��Ϊ�ַ�  
    carpath_train=strcat('.\SAR_ATR\training\s',num2str(i),'\');  
    carpath_test=strcat('.\SAR_ATR\testing\s',num2str(i),'\');
    for j=1:n_pic  
        if flag==0  
            %����strcat(a,b,...)˵��:�������ַ�a,b...���ӳɵ����ַ�  
            carpath=strcat(carpath_train,num2str(j));  
        else  
            carpath=strcat(carpath_test,num2str(j));  
        end  
        realclass((i-1)*n_pic+j)=i;  
        carpath=strcat(carpath,'.jpg');  
        %����imread˵������ȡ����·����ͼƬ����ÿ�����ػҶ�ֵ����������ľ�����  
        img=imread(carpath);
        f_matrix((i-1)*n_pic+j,:)=img(:)';  
    end  
end  
end  
