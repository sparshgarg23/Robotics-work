function []=meanshift1(x,r)


x1=x.data;
r1=r;
[clustCent,point2cluster,clustMembsCell] = findoptpeaks1(x1,r1);
numClust = length(clustMembsCell);
figure(10),clf,hold on
cVec = 'bgrcmykbgrcmykbgrcmykbgrcmyk';%, cVec = [cVec cVec];
for k = 1:min(numClust,length(cVec))
    myMembers = clustMembsCell{k};
    myClustCen = clustCent(:,k);
    plot(x1(1,myMembers),x1(2,myMembers),[cVec(k) '.'])
    plot(myClustCen(1),myClustCen(2),'o','MarkerEdgeColor','k','MarkerFaceColor',cVec(k), 'MarkerSize',10)
end
title([' numClust:' int2str(numClust)])
end