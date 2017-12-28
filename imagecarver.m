I = imread('source.jpg');
figure(1)
imshow(I);
A=rgb2gray(I);
A1=im2double(A);
[x,y]=gradient(A1);
energy_image=sqrt(x.^2+y.^2);
%Show Energy image
imshow(energy_image);
for i=1:20
    [I,energy]=reduce_height(I,energy_image);
end
figure(2)
imshow(I);

     