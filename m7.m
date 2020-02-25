% An example of implementing principal component analysis (PCA) 

%Story: Our goal is to visually compare (in 3 a dimensional space) health insurance systems
% of 100 different countries using 30 different criteria.  Therefore, our dataset consists of 100 data
% points in 30-dimensional space (each criterion is a feature). For this purpose, all we have to do is
% using PCA to reduce the dimensionality of the data from 30 to 3 and then
% plot the projected data points.

clc         % clean Matlab Command window
clear all   %clear all variables in memory (make Matlab Workspace empty)
load m7Data  %load data for this example
mu=mean(data);
Covariance=cov(data); %calculate covariance matrix of data. Note: to use Matlab command
%"cov" you need to make sure that each column represents a feature. Here we
%have 30 features (30 columns)

ScatterMat=(size(data,1)-1)*Covariance;  %Calculate scatter matrix of the data

[V,D]=eig(ScatterMat); %Perform eigenvalue decomposition
%V is a 30 by 30 diagonal matrix where the 30 elements on the diagonal represent 
%30 eigenvalues.D is a 30 by 30 matrix whose columns represent 30 eigen
%vectors

figure
bar(flipud(diag(D))); title('plot of eignevalues'); %here we make a bar plot of 30 obtained eigen values
%Note many of the eigen values are very small (almost equal to zero)

Newd = 3; %new dimensionality is 3, this means we would like to decrease the dimensionality of the data
%from 30 to 3

w=V(:,end-Newd+1:end); % we choose the bases of our new coordinate systems 
% as the eigenvectors corresponding to 3 largest eigenvalues

Pdata=(data-mu)*w; %We project the originak data to the new coordinate system.
%(As a result pdata has only 3 columns instead of original 30 columns)

figure
scatter3(Pdata(:,1),Pdata(:,2),Pdata(:,3),'r','filled');
%here we make a scatter plot of the projected data. 
%Note that our projected data consist of 100 points in 3-dimensional space.
%if the new dimensionality was 2, instead of Matlab command "scatter3", you
%should have used "scatter" (Refer to Lecture15Example.m for a
%2-dimensional scatter plot).
title('the projected data from 100 countries on 3 dimensional space')



