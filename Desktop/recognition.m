function recognition(mA,V,model,nclasses,npic)   
%�������ã���ʶ��ģ�飬�����Ѿ����õ�ģ�ͣ�������һ����������ʶ��  
%���룺  
%           mA-��ֵ  
%           V-Э���������������  
%           model-ͨ��SVM��ѵ����ѵ���ó����Ѿ������õ�ģ��  
%%  
global imgrow;    
global imgcol;    
%%  
%���������ѡ��Ҫʶ���ͼƬ  
select_class_num=str2double(cell2mat(inputdlg(strcat('��������Ҫʶ���SARĿ������ı��(�ܹ�',num2str(nclasses),'��Ŀ��)��')))); %�ܹ�nclasses��Ŀ��  
select_img_num=str2double(cell2mat(inputdlg(strcat('���������Ŀ��Ĳ���ͼƬ�ı��(�ܹ�',num2str(npic),'��)��'))));%�ܹ�npic��ͼ  
%%  
%��ͼƬ��Ϣ���д�����Ϊ1*16384��������  
disp('��ȡѡ���ͼƬ...')    
select_carpath=strcat('.\SAR_ATR\testing\s',num2str(select_class_num),'\',num2str(select_img_num),'.jpg');  
select_img=imread(select_carpath);
select_matrix=zeros(1,imgrow*imgcol);  
select_matrix(1,:)=select_img(:)';  
select_matrix=(select_matrix-mA)*V;%PCA��ά��ĵ�ά��ʾ  
%%  
%ͼ�ι�һ��  
disp('�淶��ѡ���ͼƬ...')    
select_matrix = scaling( select_matrix,min(select_matrix),max(select_matrix));    
%%  
%����ѡ���ͼƬ��accuracyֻ������ֵ��100%��ʾƥ����ȷ��0%��ʾƥ�����  
disp('����ѡ���ͼƬ...')    
[select_predict_label,accuracy,decision_values]=svmpredict(select_class_num,select_matrix,model);  
%%  
%��ʾԭ��ͼƬ��ƥ��ͼƬ���бȽ�  
disp('��ʾѡ���ͼƬ...')    
figure(2);  
subplot(1,2,1);imshow(select_img);title('��ѡ���ͼƬ');  
subplot(1,2,2);  
imshow(imread(strcat('.\SAR_ATR\training\s',num2str(select_predict_label),'\',num2str(1),'.jpg')));  
title('ƥ���ͼƬ'); 
