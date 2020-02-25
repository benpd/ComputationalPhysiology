%%Example of plotting ROC curve for fish classfication (1:seabass, 0:
%%salmon)
FishSkinTone=[-2 -1 0 1 3.9 1 1.5 2 2.5 3.9];  %Given skin tone values for 10 different fish
GroundTruth=[1 1 1 1 1 0 0 0 0 0]; %given ground truth (true fish labels)


Likehd1=normpdf(FishSkinTone,mean(FishSkinTone(1:5)),std(FishSkinTone(1:5)));
Likehd2=normpdf(FishSkinTone,mean(FishSkinTone(6:10)),std(FishSkinTone(6:10)));
LikehdRatio=Likehd1./Likehd2;
[FPR, TPR]=rocSH(LikehdRatio,GroundTruth);
figure
plot(FPR,TPR,'ro-');xlabel('FPR');ylabel('TPR');title('ROC curve')
AreaUnderROC=trapz(FPR,TPR)



