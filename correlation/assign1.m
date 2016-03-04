load('ABSHAKEB.mat');
fs=200;
ts=1/fs;
b=B;
a=DATA;
shravan_max=b(1);
nx=1:84;
for i=1:64
    for j=1:64
        temporary(j)=b(((i-1)*64)+j);
    end
    for k=65:84
        temporary(k)=0;
    end
    [z1,tx,ty,tz,y1]=corr1(a,temporary,nx,fs,ts);
    if max(z1)>shravan_max
        shravan_max=max(z1);
        shravan_max_index=i;
    end
end
tx=tx+shravan_max;
row_shravan=shravan_max_index;
for i=1:64
    founded(i)=b(((row_shravan)*64)+i);
end
[final,f1,f2,f3,f4]=corr1(a,b(row_shravan,:),nx,fs,ts);
%plot(final);
tx=1:84;
ty=1:64;
%figure();
%subplot(2,1,1);plot(tx,DATA);xlabel('Time(sec)');ylabel('x(t)');
%subplot(2,1,2);plot(ty,founded);xlabel('Time(sec)');ylabel('y1(t)');
tx=-73:73;
plot(tx,final);xlabel('Time(sec)');ylabel('z4(t)');