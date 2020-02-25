% Example of a Bayesian Classification using 1D Gaussian distribution (two
% classes)
clc
clear all
X=5:0.01:30;
Likehd1=normpdf(X,13,2);
Likehd2=normpdf(X,11,1);
Prior1=2/3;
Prior2=1/3;
Post1=(Prior1*Likehd1)./(Prior1*Likehd1+Prior2*Likehd2);
Post2=(Prior2*Likehd2)./(Prior1*Likehd1+Prior2*Likehd2);

figure
subplot(2,1,1)
plot(X,Likehd1,'b-',X,Likehd2,'r-')
legend('Likelihood for Seabass','Likelihood for Salmon')
xlabel('x (fish length)'), ylabel('p(x|w_i)')
title('Likelihood')

subplot(2,1,2)
plot(X,Post1,'b-',X,Post2,'r-')
legend('Posteriori for Seabass','Posteriori for Salmon')
xlabel('x (fish length)'), ylabel('p(w_i|x)')
title('posteriori')


% Example of a Bayesian Classification using 1D Gaussian distribution
% (three classes)

X=5:0.01:30;
Likehd1=normpdf(X,13,2);
Likehd2=normpdf(X,11,1);
Likehd3=normpdf(X,15,sqrt(2));
Prior1=1/4;
Prior2=1/4;
Prior3=1/2;
Post1=(Prior1*Likehd1)./(Prior1*Likehd1+Prior2*Likehd2+Prior3*Likehd3);
Post2=(Prior2*Likehd2)./(Prior1*Likehd1+Prior2*Likehd2+Prior3*Likehd3);
Post3=(Prior3*Likehd3)./(Prior1*Likehd1+Prior2*Likehd2+Prior3*Likehd3);


figure
subplot(2,1,1)
plot(X,Likehd1,'b-',X,Likehd2,'r-',X,Likehd3,'k-')
legend('Likelihood for Seabass','Likelihood for Salmon','Likelihood for Catfish')
xlabel('x (fish length)'), ylabel('p(x|w_i)')
title('Likelihood')

subplot(2,1,2)
plot(X,Post1,'b-',X,Post2,'r-',X,Post3,'k-')
legend('Posteriori for Seabass','Posteriori for Salmon','Posteriori for Catfish')
xlabel('x (fish length)'), ylabel('p(w_i|x)')
title('posteriori')