%%  
%�����򣬳���Ӵ˿�ʼ  
% s1----BMP-2����
% s2----BTR-70װ�׳�
% s3----T-72̹��
%%%%%%%%%%%%%%%

clc,clear
close all;
nclasses=3;   %ѡȡ3��Ŀ������    
npic = 162;   %ÿ��Ŀ�꣬ѡȡ162��ͼƬ����ѵ����162�Ž��в���
global imgrow;    
global imgcol;    
imgrow=128;    
imgcol=128;    
%%  
%��ȡѵ������   
disp('��ȡѵ������...')    
[f_matrix,train_label]=ReadPIC(nclasses,npic,0);%��ȡѵ������    
ncars=size(f_matrix,1);%����������    
disp('.................................................')    
%��ά�ռ��ͼ���ǣ�n_classes*n_pic��*k�ľ���ÿ�д���һ�����ɷֳ���ÿ��ͼ20ά����    
%%  
%��ѵ�������н�ά����  
disp('ѵ������PCA������ȡ...')    
mA=mean(f_matrix);    
k=40;  %��ά��40ά������k����С�ڵ���nclasses*npic�˻�
%����������Э��������ά����16384ά����ѵ��������������ֻ��459
%��ô�����õ�����ֵ��Ӧ����������С�ڵ���458�������������������Ӧ������ֵ��Ϊ0  
[train_pcacar,V]=fastPCA(f_matrix,k,mA);%���ɷַ�����������ȡ    
disp('.................................................')    
  
%%  
%��ʾ���ɷֳ���������������ά�Ļ�  
disp('��ʾ���ɷֳ�...')    
visualize(V,k)%��ʾ��������,��������  
disp('.................................................')    
    
%%  
%��άѵ������һ��  
disp('ѵ���������ݹ�һ��...')    
disp('.................................................')    
lowvec=min(train_pcacar);    
upvec=max(train_pcacar);    
train_scaledcar = scaling( train_pcacar,lowvec,upvec);    
   
%%  
%SVM����ѵ��  
%ʹ�õ���libsvm���������SVM����  
disp('SVM����ѵ��...')    
disp('.................................................')    
 %model = svmtrain(train_label,train_scaledcar,'-t 0');  %���Ժ˺���
 model = svmtrain(train_label,train_scaledcar,'-t 2 -g 0.4'); %������˺���
   
 %%  
 %��ȡ��������  
disp('��ȡ��������...')    
disp('.................................................')    
[test_cardata,test_carlabel]=ReadPIC(nclasses,npic,1);    
    
%%  
%�������ݽ�ά  
%test_pcatestcar-�������ݵ�ά�ռ�ı�ʾ  
disp('��������������ά...')    
disp('.................................................')    
m=size(test_cardata,1);    
for i=1:m    
    test_cardata(i,:)=test_cardata(i,:)-mA;    
end    
test_pcatestcar=test_cardata*V;    
    
%%  
%�������ݹ�һ��  
disp('�����������ݹ�һ��...')    
disp('.................................................')    
scaled_testcar = scaling( test_pcatestcar,lowvec,upvec);    
    
%%  
%����ѵ����������ģ�ͣ��Բ��Լ����з���  
disp('SVM��������...')    
disp('.................................................')    
[predict_label,accuracy,decision_values]=svmpredict(test_carlabel,scaled_testcar,model);  
  
%%  
%��ʶ��ģ��  
disp('��ʶ��ģ��')  
disp('.................................................')    
recognition(mA,V,model,nclasses,npic) ;
