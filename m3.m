%%% Example of a Bayesian Classification using 2 features with Gaussian distribution (2 classes)
clc
clear all
warning off
MU1=[3;3];
SIGMA1=[2 0; 0 2];
Prior1=0.2;
LikehdPrior1 =@(x1,x2) ((Prior1/(sqrt(4*(pi^2)*det(SIGMA1))))*exp(-0.5*([x1-MU1(1),x2-MU1(2)]*inv(SIGMA1)*[x1-MU1(1);x2-MU1(2)])));

MU2=[-1 -1];
SIGMA2=[2 0; 0 2];
Prior2=0.8;
LikehdPrior2 =@(x1,x2) ((Prior2/(sqrt(4*(pi^2)*det(SIGMA2))))*exp(-0.5*([x1-MU2(1),x2-MU2(2)]*inv(SIGMA2)*[x1-MU2(1);x2-MU2(2)])));
figure
fmesh(LikehdPrior1,[-6 6 -6 6]);hold on;fmesh(LikehdPrior2,[-6 6 -6 6]);axis square; colorbar


figure
fcontour(LikehdPrior1,[-6 6 -6 6]);hold on;fcontour(LikehdPrior2,[-6 6 -6 6]);grid;axis equal; colorbar

%decision boundry
DecisionBndFun=@(x1,x2) ((Prior1/(sqrt(4*(pi^2)*det(SIGMA1))))*exp(-0.5*([x1-MU1(1),x2-MU1(2)]*inv(SIGMA1)*[x1-MU1(1);x2-MU1(2)])))-((Prior2/(sqrt(4*(pi^2)*det(SIGMA2))))*exp(-0.5*([x1-MU2(1),x2-MU2(2)]*inv(SIGMA2)*[x1-MU2(1);x2-MU2(2)])));
hold on;fimplicit(DecisionBndFun,[-6 6 -6 6])
