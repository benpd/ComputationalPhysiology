%%% Example of a Bayesian Classification using more than 2 features (2
%%% classes)--Is the patient at the risk of developing heart disease?
clc
clear all
MU1=[115;80;150;30;4];
SIGMA1=diag([225;400;400;100;4]);
Prior1=0.9;

MU2=[145;40;190;45;7];
SIGMA2=SIGMA1;
Prior2=0.1;

X=[129;60;160;50;8];

if (mvnpdf(X,MU1,SIGMA1)/mvnpdf(X,MU2,SIGMA1))>(Prior2/Prior1)
    Decision='No risk';
else
    Decision='At risk of developing heart disease';
end






