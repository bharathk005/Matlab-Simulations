clc;
n=input('no. of pixel values u want:');
%pts = round(readPoints('I:\SAM Ph.D WORK\MY MATLAB CODE\JAFFE\KA.HA2.30.tiff', n))
 pts = round(readPoints('C:\Users\bharath\Downloads\4.png', n));
hp = impixelinfo; %% if u want u can add
set(hp,'Position',[150 290 300 20])
%a=imread('I:\SAM Ph.D WORK\MY MATLAB CODE\JAFFE\KA.HA2.30.tiff');
 a=imread('C:\Users\bharath\Downloads\4.png');
size(a)
pixel = zeros(1,n);
for k=1:n
    pixel(:,k) = a(pts(1,k),pts(2,k));
end
pixelvalues=pixel;
disp(pixelvalues);