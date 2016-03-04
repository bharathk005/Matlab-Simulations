function [ z,tx,ty,tz,y ] = corr1(a,x,nx,f,ts )
fs=1/ts;
ny=1:84;
y=1;
n5=[0:100];
nl=ny(1)-nx(length(x))+1;
nh=ny(length(a))-nx(1)+1;
nz=[nl:nh];
for n=1:length(nz)
    z(n)=0;
    for k=1:length(a)
        if(length(x)-n+k)<=length(x) && length(x)-n+k >0
            z(n)=z(n)+a(k)*x(length(x)-n+k);
        end
    end
end
z=fliplr(z);
tx=nx/fs;
ty=ny/fs;
tz=nz/fs;
end

