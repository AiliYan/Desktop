function recognition(mA,V,model,nclasses,npic)   
%函数作用：车识别模块，利用已经建好的模型，重新找一个样本进行识别  
%输入：  
%           mA-均值  
%           V-协方差矩阵特征向量  
%           model-通过SVM对训练集训练得出的已经建立好的模型  
%%  
global imgrow;    
global imgcol;    
%%  
%弹出输入框，选择要识别的图片  
select_class_num=str2double(cell2mat(inputdlg(strcat('请输入想要识别的SAR目标种类的编号(总共',num2str(nclasses),'类目标)：')))); %总共nclasses类目标  
select_img_num=str2double(cell2mat(inputdlg(strcat('请输入此类目标的测试图片的编号(总共',num2str(npic),'张)：'))));%总共npic张图  
%%  
%对图片信息进行处理，化为1*16384的行向量  
disp('读取选择的图片...')    
select_carpath=strcat('.\SAR_ATR\testing\s',num2str(select_class_num),'\',num2str(select_img_num),'.jpg');  
select_img=imread(select_carpath);
select_matrix=zeros(1,imgrow*imgcol);  
select_matrix(1,:)=select_img(:)';  
select_matrix=(select_matrix-mA)*V;%PCA降维后的低维表示  
%%  
%图形归一化  
disp('规范化选择的图片...')    
select_matrix = scaling( select_matrix,min(select_matrix),max(select_matrix));    
%%  
%测试选择的图片，accuracy只有两个值，100%表示匹配正确，0%表示匹配错误  
disp('测试选择的图片...')    
[select_predict_label,accuracy,decision_values]=svmpredict(select_class_num,select_matrix,model);  
%%  
%显示原有图片和匹配图片进行比较  
disp('显示选择的图片...')    
figure(2);  
subplot(1,2,1);imshow(select_img);title('你选择的图片');  
subplot(1,2,2);  
imshow(imread(strcat('.\SAR_ATR\training\s',num2str(select_predict_label),'\',num2str(1),'.jpg')));  
title('匹配的图片'); 
