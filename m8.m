% Comparsion of results classification using Linear Discriminant Analysis (LDA),
%Fisher Discriminant Ratio (FDR) and principal component analysis (PCA) 


%Story: We have the results of 5 medical tests performed on two groups of people:
%Group 1 consists of 100 subjects with no risk of developing the heart disease (Y1)and Group 2
%consists of 100 subjects with risk of developing the heart disease (Y2). Therefore, our 
%dataset consists of 100 data points in 5-dimensional space (each medical test is a feature)from Group
% 1 and 100 data points in 5-dimensional space from Group2. Our goal is to
% A) 
% visually compare (in a 1-dimesnioal space) the medical test results from
% 2 groups. Therefore, all we have to do is to reduce the dimensionality of
% the data from 5 to 1. For this purpose, we use three diffirent method
% (LDA,FDR and PCA) and compare the results. Out of the three methods, we choose the
% one which results in better visual separation of two groups.
%B)
%Quantitatively compare the three methods. For this purpose,
% we use a given decision criterion to classify each projected data and then
%calculate the average probability of error for each of three methods. We
%choose the method with smallest probability of error. Suppose the given
%decision creiterion is that if the projected data point is above 0, we
%classify it as Class 1 and otherwise as class2.


clc         % clean Matlab Command window
clear all   %clear all variables in memory (make Matlab Workspace empty)
load m8Data


%***********************part A********************************************
%% LDA
mu1=mean(Y1);  %Calculate mean vector of data from group1
mu2=mean(Y2);  %Calculate mean vector of data from group2
S1=(length(Y1)-1)*cov(Y1); %Calculate scatter matrix of data from group1
S2=(length(Y2)-1)*cov(Y2); %Calculate scatter matrix of data from group2
Sw1=S1+S2;                  %Calculate within-class scatter matrix 
w1=inv(Sw1)*(mu1'-mu2');   %calculate projecting vector 
w1=w1/norm(w1);  %Normalize vector w1
ProjY1LDA=(Y1-0.5*(mu1+mu2))*w1;  %projected Y1 data in a one dimensional space
ProjY2LDA=(Y2-0.5*(mu1+mu2))*w1;  %projected Y2 data in a one dimensional space
figure
subplot 311
scatter(ProjY1LDA,zeros(length(ProjY1LDA),1),'bs','filled');
hold on;
scatter(ProjY2LDA,zeros(length(ProjY2LDA),1),'r');
legend('No risk','at risk of heart disease')
title('dimensionality reduction using LDA');
%here we make a scatter plot of the projected data using LDA. 
%Note that our projected data consist of 100 points from each group in
%1-dimensional space.

%% PCA on the data from group1
mu1=mean(Y1);
Covariance=cov(Y1); %calculate covariance matrix of Y1. Note: to use Matlab command
%"cov" you need to make sure that each column represents a feature. Here we
%have 5 features (5 columns)

ScatterMat=(size(Y1,1)-1)*Covariance;  %Calculate scatter matrix of the data

[V,D]=eig(ScatterMat); %Perform eigenvalue decomposition
%V is a 5 by 5 diagonal matrix where the 5 elements on the diagonal represent 
%30 eigenvalues.D is a 5 by 5 matrix whose columns represent 5 eigen
%vectors

Newd = 1; %new dimensionality is 1, this means we would like to decrease the dimensionality of the data
%from 5 to 1

w=V(:,end-Newd+1:end); % we choose the bases of our new coordinate systems 
% as the eigenvectors corresponding to the largest eigenvalues

ProjY1PCA=(Y1-mu1)*w; %We project data from group1 to the new coordinate system.
%(As a result ProjY1 has only 1 column instead of original 5 columns)
ProjY2PCA=(Y2-mu2)*w; %We project data from group2 to the new coordinate system.
%(As a result ProjY2 has only 1 column1 instead of original 5 columns)

subplot 312
scatter(ProjY1PCA,zeros(length(ProjY1PCA),1),'bs','filled');
hold on;
scatter(ProjY2PCA,zeros(length(ProjY2PCA),1),'r');
legend('No risk','at risk of heart disease')
title('dimensionality reduction using PCA');
%here we make a scatter plot of the projected data using PCA. 
%Note that our projected data consist of 100 points from each group in
%1-dimensional space.

%%FDR
FDRVect=zeros(size(Y1,2),1); %each element of FDRVect is the calculated FDR for the corresponding feature
for i=1:size(Y1,2)  %for each feature do the following
    data1=Y1(:,i);  % take the values of corresponding features from 100 subjects in group1
    data2=Y2(:,i);  % take the values of corresponding features from 100 subjects in group2
    FDR(i)=((mean(data1)-mean(data2))^2)/(var(data1)+var(data2)); %calculate FDR of the corresponding feature using FDR formula (look at your lecture notes)
end;
[V2,I]=sort(FDR,'descend');  %sort FDR in descending order
FeatIdx=I(1:Newd); %index of the selected features (choose the 2 features with the highest FDR value)
   
ProjY1FDR=Y1(:,FeatIdx);  %projected data from group1
ProjY2FDR=Y2(:,FeatIdx);  %projected data from group2

subplot 313
scatter(ProjY1FDR,zeros(length(ProjY1FDR),1),'bs','filled');
hold on;
scatter(ProjY2FDR,zeros(length(ProjY2FDR),1),'r');
legend('No risk','at risk of heart disease')
title('dimensionality reduction using FDR');
%here we make a scatter plot of the projected data using FDR. 
%Note that our projected data consist of 100 points from each group in
%1-dimensional space.

%Result shows that the projected data points using LDA is better seprated
%than those of PCA and FDR. 


%**********************Part B ******************************************
%given decision creiterion is that if the projected data point is above 0, we
%classify it as Class 1 and otherwise as class2.

%% Calculate average probability of error for PCA
FN=0;
for i=1:length(ProjY1PCA)  %for all projected data point from class 1
    if ProjY1PCA(i)<=0  % if the projected value is smaller or equal to 0, it would be wrongly classified as class2 (False Negative)
        FN=FN+1;  %count the number of FN
    end;
end
ProbMPCA=FN/100;  %probability of missing for PCA

FP=0;
for i=1:length(ProjY2PCA) %for all projected data point from class 2
    if ProjY2PCA(i)>0 % if the projected value is greater than 0, it would be wrongly classified as class1 (False Positive)
        FP=FP+1;
    end;
end
ProbFAPCA=FP/100; %probability of False Alarm for PCA
ErrorPrbPCA=0.5*(ProbMPCA+ProbFAPCA)  %average probablity of error of PCA is the average of Prob of miss and prob of False Alram

%% Calculate average probability of error for FDR
FN=0;
for i=1:length(ProjY1FDR)  %for all projected data point from class 1
    if ProjY1FDR(i)<=0  % if the projected value is smaller or equal to 0, it would be wrongly classified as class2 (False Negative)
        FN=FN+1;  %count the number of FN
    end;
end
ProbMFDR=FN/100;  %probability of missing for FDR

FP=0;
for i=1:length(ProjY2FDR) %for all projected data point from class 2
    if ProjY2FDR(i)>0 % if the projected value is greater than 0, it would be wrongly classified as class1 (False Positive)
        FP=FP+1;
    end;
end
ProbFAFDR=FP/100; %probability of False Alarm for FDR
ErrorPrFDR=0.5*(ProbMFDR+ProbFAFDR)  %average probablity of error of FDR is the average of Prob of miss and prob of False Alram

%% Calculate average probability of error for LDA
FN=0;
for i=1:length(ProjY1LDA)  %for all projected data point from class 1
    if ProjY1LDA(i)<=0  % if the projected value is smaller or equal to 0, it would be wrongly classified as class2 (False Negative)
        FN=FN+1;  %count the number of FN
    end
end
ProbMLDA=FN/100;  %probability of missing for LDA

FP=0;
for i=1:length(ProjY2LDA) %for all projected data point from class 2
    if ProjY2LDA(i)>0 % if the projected value is greater than 0, it would be wrongly classified as class1 (False Positive)
        FP=FP+1;
    end
end
ProbFALDA=FP/100; %probability of False Alarm for LDA
ErrorPrLDA=0.5*(ProbMLDA+ProbFALDA)  %average probablity of error of LDA is the average of Prob of miss and prob of False Alram

%Result shows that the average probability of error of LDA is smallest!
