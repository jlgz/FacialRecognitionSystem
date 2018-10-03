function ej53
%A)
close all;
figure();
addpath('ViolaJones','ViolaJones/SubFunctions');
[X,Y] = getDataBase([20,20],15);
model=uint8(round(reshape(mean(X(Y==1,:),1),[20,20]))); %average face
%model(7:10,3:3+13) = 0; %rectangle without using rectangle()
%model(9:10,3:3+13) = 255;
imshow(model);
rectangle('position',[3 ,7,14,4],'facecolor','k');
rectangle('position',[3,9,14,2],'facecolor','w');
%B)
figure(); %showing integral images
I = imread('images/natural.jpg');
subplot(2,3,1),
imshow(I);
subplot(2,3,4)
showIntegralImage(I);
I = imread('images/landscape.jpg');
subplot(2,3,2),
imshow(I);
subplot(2,3,5),
showIntegralImage(I);
I = imread('images/room.jpg');
subplot(2,3,3),
imshow(I);
subplot(2,3,6),
showIntegralImage(I);
defaultoptions.Resize=false;		%computing the characteristic value using the integral image	
modelInt=GetIntegralImages(model,defaultoptions);
CharValue = (modelInt.ii(10,16)- modelInt.ii(9,16) -modelInt.ii(10,3) + modelInt.ii(9,3))*2 - (modelInt.ii(10,16)- modelInt.ii(7,16) -modelInt.ii(10,3) + modelInt.ii(7,3))
% figure();
% % C)
% ConvertHaarcasadeXMLOpenCV('ViolaJones/HaarCascades/haarcascade_frontalface_alt.xml');
% % Detect Faces
% Options.Resize=false;
% subplot(1,2,1),
% ObjectDetection('Images/testFaces1.jpg','ViolaJones/HaarCascades/haarcascade_frontalface_alt.mat',Options);
% subplot(1,2,2),
% ObjectDetection('Images/testFaces2.jpg','ViolaJones/HaarCascades/haarcascade_frontalface_alt.mat',Options);
% % D)
% figure();
% subplot(2,3,1),
% ObjectDetection('faces1.jpg','ViolaJones/HaarCascades/haarcascade_frontalface_alt.mat',Options);
% subplot(2,3,3),
% ObjectDetection('nofaces1.jpg','ViolaJones/HaarCascades/haarcascade_frontalface_alt.mat',Options);
% subplot(2,3,4),
% ObjectDetection('faces2.jpg','ViolaJones/HaarCascades/haarcascade_frontalface_alt.mat',Options);
% subplot(2,3,5),
% ObjectDetection('nofaces2.jpg','ViolaJones/HaarCascades/haarcascade_frontalface_alt.mat',Options);
% subplot(2,3,6),
% ObjectDetection('faces3.jpg','ViolaJones/HaarCascades/haarcascade_frontalface_alt.mat',Options);
% figure();
% subplot(2,3,1),
% ObjectDetection('nofaces3.jpg','ViolaJones/HaarCascades/haarcascade_frontalface_alt.mat',Options);
% subplot(2,3,3),
% ObjectDetection('faces4.jpg','ViolaJones/HaarCascades/haarcascade_frontalface_alt.mat',Options);
% subplot(2,3,4),
% ObjectDetection('nofaces4.jpg','ViolaJones/HaarCascades/haarcascade_frontalface_alt.mat',Options);
% subplot(2,3,5),
% ObjectDetection('faces5.jpg','ViolaJones/HaarCascades/haarcascade_frontalface_alt.mat',Options);
% subplot(2,3,6),
% ObjectDetection('nofaces5.jpg','ViolaJones/HaarCascades/haarcascade_frontalface_alt.mat',Options);
end
function showIntegralImage(image)
defaultoptions.Resize=false;			
intImageStruct=GetIntegralImages(image,defaultoptions);
imagesc(intImageStruct.ii);colormap(jet);
end


