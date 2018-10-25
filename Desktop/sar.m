%%  
%主程序，程序从此开始  
% s1----BMP-2卡车
% s2----BTR-70装甲车
% s3----T-72坦克
%%%%%%%%%%%%%%%

clc,clear
close all;
nclasses=3;   %选取3类目标样本    
npic = 162;   %每类目标，选取162张图片进行训练，162张进行测试
global imgrow;    
global imgcol;    
imgrow=128;    
imgcol=128;    
%%  
%读取训练数据   
disp('读取训练数据...')    
[f_matrix,train_label]=ReadPIC(nclasses,npic,0);%读取训练数据    
ncars=size(f_matrix,1);%样本的数量    
disp('.................................................')    
%低维空间的图像是（n_classes*n_pic）*k的矩阵，每行代表一个主成分车，每个图20维特征    
%%  
%对训练集进行降维处理  
disp('训练数据PCA特征提取...')    
mA=mean(f_matrix);    
k=40;  %降维至40维，这里k必须小于等于nclasses*npic乘积
%按理来讲，协方差矩阵的维数是16384维，而训练集的样本数量只有459
%那么起作用的特征值对应的特征向量小于等于458个，其余的特征向量对应的特征值都为0  
[train_pcacar,V]=fastPCA(f_matrix,k,mA);%主成分分析法特征提取    
disp('.................................................')    
  
%%  
%显示主成分车，即特征车，低维的基  
disp('显示主成分车...')    
visualize(V,k)%显示主分量车,即特征车  
disp('.................................................')    
    
%%  
%低维训练集归一化  
disp('训练特征数据归一化...')    
disp('.................................................')    
lowvec=min(train_pcacar);    
upvec=max(train_pcacar);    
train_scaledcar = scaling( train_pcacar,lowvec,upvec);    
   
%%  
%SVM样本训练  
%使用的是libsvm工具箱进行SVM分类  
disp('SVM样本训练...')    
disp('.................................................')    
 %model = svmtrain(train_label,train_scaledcar,'-t 0');  %线性核函数
 model = svmtrain(train_label,train_scaledcar,'-t 2 -g 0.4'); %径向基核函数
   
 %%  
 %读取测试数据  
disp('读取测试数据...')    
disp('.................................................')    
[test_cardata,test_carlabel]=ReadPIC(nclasses,npic,1);    
    
%%  
%测试数据降维  
%test_pcatestcar-测试数据低维空间的表示  
disp('测试数据特征降维...')    
disp('.................................................')    
m=size(test_cardata,1);    
for i=1:m    
    test_cardata(i,:)=test_cardata(i,:)-mA;    
end    
test_pcatestcar=test_cardata*V;    
    
%%  
%测试数据归一化  
disp('测试特征数据归一化...')    
disp('.................................................')    
scaled_testcar = scaling( test_pcatestcar,lowvec,upvec);    
    
%%  
%利用训练集建立的模型，对测试集进行分类  
disp('SVM样本分类...')    
disp('.................................................')    
[predict_label,accuracy,decision_values]=svmpredict(test_carlabel,scaled_testcar,model);  
  
%%  
%车识别模块  
disp('车识别模块')  
disp('.................................................')    
recognition(mA,V,model,nclasses,npic) ;
