function [f_matrix,realclass]=ReadPIC(n_classes,n_pic,flag)  
%MSTAR库。JPG格式的图片。n_classes种目标，训练和测试各选择n_pic幅图，图像大小为128*128像素。  
%3种目标，n_pic幅当作训练集，放在training目录下，n_pic幅当作测试集，放在testing目录下
%  
%输入变量flag:  
%   flag是一个标识变量  
%   当flag为0时，表示输入为训练集，flag为1时，表示输入为测试集  
%  
%输入变量n_classes：  
%   n_classes标志着你想要识别的SAR图像目标的种类
%  
%输出变量realclass：  
%   realclass是一个n_classes*n_pic行，1列的列向量。  
%   realclass即是数据的标签，无论训练集测试集都进行了标签处理  
%  
%输出变量f_matrix:  
%   f_matrix是一个n_classes*n_pic行，128*128列的矩阵  
%   每一行便是每一张图片的灰度数据  
%   将每一张图片列向量排成一个列向量后转置得到放入f_matrix各行当中  
  
imgrow=128;imgcol=128;  
global imgrow;   %载入图片行数  
global imgcol;    %载入图片列数  
realclass=zeros(n_classes*n_pic,1);  
f_matrix=zeros(n_classes*n_pic,imgrow*imgcol);  
for i=1:n_classes  
    %路径设置  
    %函数num2str(i)说明：将数字转化为字符  
    carpath_train=strcat('.\SAR_ATR\training\s',num2str(i),'\');  
    carpath_test=strcat('.\SAR_ATR\testing\s',num2str(i),'\');
    for j=1:n_pic  
        if flag==0  
            %函数strcat(a,b,...)说明:将输入字符a,b...连接成单个字符  
            carpath=strcat(carpath_train,num2str(j));  
        else  
            carpath=strcat(carpath_test,num2str(j));  
        end  
        realclass((i-1)*n_pic+j)=i;  
        carpath=strcat(carpath,'.jpg');  
        %函数imread说明：读取输入路径的图片，将每个像素灰度值保存在输出的矩阵中  
        img=imread(carpath);
        f_matrix((i-1)*n_pic+j,:)=img(:)';  
    end  
end  
end  
