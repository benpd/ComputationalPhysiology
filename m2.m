% Example on how to plot 2D Gaussian Density

%%% comparsion of 2 PDFs with different mean vectors
clc
clear all
MU=[1;2];
SIGMA=[4 0; 0 9];

figure
PDF1 =@(x1,x2) ((1/(sqrt(4*(pi^2)*det(SIGMA))))*exp(-0.5*([x1-MU(1),x2-MU(2)]*inv(SIGMA)*[x1-MU(1);x2-MU(2)])));
subplot(2,2,1)
fmesh(PDF1,[-10 10 -10 10]);
subplot(2,2,2)
fcontour(PDF1,[-10 10 -10 10]);grid;axis equal


MU=[-1;-3];
SIGMA=[4 0; 0 9];

PDF2 =@(x1,x2) ((1/(sqrt(4*(pi^2)*det(SIGMA))))*exp(-0.5*([x1-MU(1),x2-MU(2)]*inv(SIGMA)*[x1-MU(1);x2-MU(2)])));
subplot(2,2,3)
fmesh(PDF2,[-10 10 -10 10]);
subplot(2,2,4)
fcontour(PDF2,[-10 10 -10 10]);grid;axis equal

%%% comparsion of 2 PDFs with different covariance matrices

MU=[1;2];
SIGMA=[4 0; 0 9];

figure
PDF3 =@(x1,x2) ((1/(sqrt(4*(pi^2)*det(SIGMA))))*exp(-0.5*([x1-MU(1),x2-MU(2)]*inv(SIGMA)*[x1-MU(1);x2-MU(2)])));
subplot(2,2,1)
fmesh(PDF3,[-10 10 -10 10]);
subplot(2,2,2)
fcontour(PDF3,[-10 10 -10 10]);grid;axis equal


MU=[1;2];
SIGMA=[25 0; 0 9];

PDF4 =@(x1,x2) ((1/(sqrt(4*(pi^2)*det(SIGMA))))*exp(-0.5*([x1-MU(1),x2-MU(2)]*inv(SIGMA)*[x1-MU(1);x2-MU(2)])));
subplot(2,2,3)
fmesh(PDF4,[-10 10 -10 10]);
subplot(2,2,4)
fcontour(PDF4,[-10 10 -10 10]);grid;axis equal


