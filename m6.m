% Example of 2-fold cross validation for fish Classification (1: seabass,
% 0: salmon)
clc
clear all
rng(1)
FishSkinTone=[ 1     1     3     0    -1     2     0     2    -2     3    -1     1     0     2    -2    -2     4 ...
    -1    -1     1    -1     1     3     1     4    -2     0    -1     1    -2     0     1     0     1 ...
    1     0     2     2     1     0     1     1    -1     3     2     0     3     1     0     1];
n=size(FishSkinTone,2);
GroundTruth=[ones(1,30),zeros(1,20)];
RP=randperm(n); %random permutation of the index of data points

fold1_idx=RP(1:n/2);
fold1_data=FishSkinTone(fold1_idx);
fold1_GroundTruth=GroundTruth(fold1_idx);

fold2_idx=RP(1+n/2:end);
fold2_data=FishSkinTone(fold2_idx);
fold2_GroundTruth=GroundTruth(fold2_idx);


%%fold 1 testing and fold 2 training
%learn/train classifier from fold2 data by finding the mean and variance of data in fold2
mu_seabass=mean(fold2_data(fold2_GroundTruth==1));
var_seabass=var(fold2_data(fold2_GroundTruth==1));
mu_salmon=mean(fold2_data(fold2_GroundTruth==0));
var_salmon=var(fold2_data(fold2_GroundTruth==0));
%test classfier on fold 1 data
Likehd1=normpdf(fold1_data,mu_seabass,sqrt(var_seabass));
Likehd2=normpdf(fold1_data,mu_salmon,sqrt(var_salmon));
LikehdRatio1=Likehd1./Likehd2;
% x=[LikehdRatio',fold1_GroundTruth']; %x has two columns, the first one is the calculate Likelihood Ratio for different cases, the second column is the ground truth
% ROCdata1=rocSH(x);
[fpr1,tpr1] = rocSH(LikehdRatio1,fold1_GroundTruth);


%%fold 2 testing and fold 1 training
%learn/train classifier from fold1 data by finding the mean and variance of
%data in fold1
mu_seabass=mean(fold1_data(fold1_GroundTruth==1));
var_seabass=var(fold1_data(fold1_GroundTruth==1));
mu_salmon=mean(fold1_data(fold1_GroundTruth==0));
var_salmon=var(fold1_data(fold1_GroundTruth==0));
%test classfier on fold 2 data
Likehd1=normpdf(fold2_data,mu_seabass,sqrt(var_seabass));
Likehd2=normpdf(fold2_data,mu_salmon,sqrt(var_salmon));
LikehdRatio2=Likehd1./Likehd2;


%plotroc(fold1_GroundTruth,LikehdRatio1,'fold1',fold2_GroundTruth,LikehdRatio2,'fold2');
[fpr2,tpr2] = rocSH(LikehdRatio2,fold2_GroundTruth);

FPR=0.5*(fpr1+fpr2);
TPR=0.5*(tpr1+tpr2);

figure;
plot(fpr1,tpr1,'ro-');hold on;
plot(fpr2,tpr2,'b*-');hold on;
plot(FPR,TPR,'ks-');xlabel('FPR');ylabel('TPR');title('ROC curve');
legend('fold 1','fold 2','final');
AreaUnderROC=trapz(FPR,TPR);
