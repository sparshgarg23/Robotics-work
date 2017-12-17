function [u,v]=KLT(I1,I2)
[row,col]=size(I1);
I(:,:,1)=I1;
I(:,:,2)=I2;
g=ones(15,15);
[Ix,Iy]=gradient(I1);
Ix2=conv2(Ix.*Ix,g,'same');
Iy2=conv2(Iy.*Iy,g,'same');
Ixy=conv2(Ix.*Iy,g,'same');
It=I2-I1;
IxIt = conv2(Ix.*It,g,'same');
IyIt = conv2(Iy.*It,g,'same');
det = 1 ./ (Ix2.*Iy2 - Ixy.*Ixy);

u = det .* -(Iy2.*IxIt - Ixy.*IyIt);
v = det .* (Ixy.*IxIt - Ix2.*IyIt);
end