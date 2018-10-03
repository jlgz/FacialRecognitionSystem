function ej52
% %A)
preder = [0.0,0.0,0.0]; %here the error in each level of the cascade
[outClass, X, Y, selFeatures, error, predErr] = haarFeatureDemo(2); %first level
outClass(outClass > 0) = 1;
tmp = outClass;
s = size(tmp(tmp == 1));
preder(1) = (s(1)-6)/21.0; %there is only 6 faces
for i=2:3
    [outClass, X, Y, selFeatures, error, predErr] =haarFeatureDemo(2,X,Y,tmp); %second and third level
    outClass(outClass > 0) = 1;
    tmp(tmp == 1) = outClass(tmp == 1);
    s = size(tmp(tmp == 1));
    preder(i) = (s(1) -6) / 21.0;
end
figure();
plot([1,2,3],preder);
pause;
%B)
[outClass, X, Y, selFeatures, error, predErr] = haarFeatureDemo(3); %one lvl with 3 characteristics
one_lvl = predErr(3);
pause;
preder = [0.0,0.0,0.0];
[outClass, X, Y, selFeatures, error, predErr] = haarFeatureDemo(1); %first lvl one characteristic
outClass(outClass > 0) = 1;
tmp = outClass;
s = size(tmp(tmp == 1));
preder(1) = (s(1)-6)/21.0;
size(tmp(tmp == 1))
for i=2:3
    [outClass, X, Y, selFeatures, error, predErr] =haarFeatureDemo(1,X,Y,tmp); %second and third lvl
    outClass(outClass > 0) = 1;
    tmp(tmp == 1) = outClass(tmp == 1);
    s = size(tmp(tmp == 1));
    preder(i) = (s(1) -6) / 21.0;
end
'error 1 nivel' % printing errors
one_lvl
'error 3 niveles'
preder(3)
end

