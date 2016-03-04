a1=10;
a2=10;
a3=10;
a4=10;
f1=10;
f2=20;
f3=30;
f4=40;
fs = 200;
ts = 1/fs;
n=1:100;

x1 = a1*sin(2*pi*n*f1*ts);
x2 = a1*sin(2*pi*n*f2*ts);
x3 = a1*sin(2*pi*n*f3*ts);
x4 = a1*sin(2*pi*n*f4*ts);

x = [x1 x2 x3 x4];
nx = 1:400;
ay = 15;
fy = f1;

ny =n;
y1 = ay*sin(2*pi*n*f1*ts);
y2 = ay*sin(2*pi*n*f2*ts);
y3 = ay*sin(2*pi*n*f3*ts);
y4 = ay*sin(2*pi*n*f4*ts);

neg = ny(1) - nx(length(x)) +1;
pos = ny(length(y1)) - nx;

nz = neg:pos;

z1 = zeros(size(nz));
z2 = zeros(size(nz));
z3 = zeros(size(nz));
z4 = zeros(size(nz));

for l = 1:length(nz)
   for j = 1:length(ny)
        if((0<(400-l+j)&&(400-l+j)<=400)&&(j<length(ny)))
            z1(l) = z1(l) + y1(j)*x(length(nx)-l+j);
            z2(l) = z2(l) + y2(j)*x(length(nx)-l+j);
            z3(l) = z3(l) + y3(j)*x(length(nx)-l+j);
            z4(l) = z4(l) + y4(j)*x(length(nx)-l+j);
        
        end
   
   
   end
    
end
z1 = fliplr(z1);
z2 = fliplr(z2);
z3 = fliplr(z3);
z4 = fliplr(z4);

nz = 1:length(nz);
nz = nz/fs;
nx = nx/fs;
ny = ny/fs;

subplot(5,1,1),plot(nx,x),title('Appended'),xlabel('<--time(s)-->'),ylabel('Amplitude');
subplot(5,1,2),plot(nz,z1),title('z1'),xlabel('<--time(s)-->'),ylabel('Amplitude');
subplot(5,1,3),plot(nz,z2),title('z2'),xlabel('<--time(s)-->'),ylabel('Amplitude');
subplot(5,1,4),plot(nz,z3),title('z3'),xlabel('<--time(s)-->'),ylabel('Amplitude');
subplot(5,1,5),plot(nz,z4),title('z4'),xlabel('<--time(s)-->'),ylabel('Amplitude');

