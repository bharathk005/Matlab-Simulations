close all;
clc;
clear all;
p0=0.3;p1=0.7;s=[];X=[];S=[];
n1=0;
n2=0;
 
for i=1:1000
    k=rand(1);
    if k>p0
        S(i)=1;
        n1=n1+1;
    else
        S(i)=0;
        n2=n2+1;
    end
end
S;
length(S);
 
for q=1:1000;
    if (S(q)==1)
        X((100*(q-1)+1):100*q)=5*ones(1,100);
       
       
    else
       X((100*(q-1)+1):100*q)=(-4)*ones(1,100);
      
       
    end
end
 
N=sqrt(10)*randn(1,100000);
Y=X+N;
for i=-4:0.01:5
    if(    (   erfc (   (i+4)/sqrt(20)   )  +   erfc(   (i-5)/sqrt(20) )) ==  2)
        th=i;
    end
end
 
 
dtt1=zeros(1,1000);
  
for i=1:1000
    Z=Y((100*(i-1))+1);
    if (Z-th>=0)
        
        dtt1(i)=1; 
    end
 
end
 
dtt1;
b1=0;
for i=1:1000
    if (S(i)-dtt1(i)==0)
     b1=b1+1;
    end
end
 
b1=(b1*100)/1000;
 
m1=sprintf('mini max technique with detection rate (percentage) = %d',b1);
%m2=sprintf('Difference between detected and transmitted signal with threshold=0 with detection rate =%d',d2);
 
subplot(4,1,1);stem(X);title('Transmitted signal');xlabel('n(seconds)');ylabel('X[n]');
subplot(4,1,2);stem(Y);title('Received signal (AGN model)');xlabel('n(seconds)');ylabel('Y[n]');
%subplot(6,1,5);stem(diff1);title(m1);xlabel('n(seconds)');ylabel('diff1[n]');
%subplot(6,1,6);stem(diff2);title(m2);xlabel('n(seconds)');ylabel('diff2[n]');
subplot(4,1,3);stem(S);title('transmitted sequence ');xlabel('n(seconds)');ylabel('detect1[n]');
subplot(4,1,4);stem(dtt1);title(m1);xlabel('n(seconds)');ylabel('detect[n]');
 
 
 
%5th
B2=[];
 
 
th1=[];
yy=1;
 
for p0=0.1:0.1:0.9 
    
    
th1=0.5+(10/9)*log(  (  p0  /  (1-p0)   ) );
 
 
dtt2=zeros(1,1000);
 
  
for i=1:1000
    Z=Y((100*(i-1))+1);
    if (Z-th1>=0)
        
        dtt2(i)=1; 
    end
 
end
 
 
b2=0;
for i=1:1000
    if (S(i)-dtt2(i)==0)
     b2=b2+1;
    end
end
 
B2(yy)=b2;
yy=yy+1;
 
end
B2=[0 B2 0]
figure()
vv=0:0.1:1;
stem(vv,B2);
xlabel( 'pi0'); ylabel('detection rate') 
title('detection rate corresponding to 10000 samples with varring probability of pi0');
j1=0;j2=0;
 
 
 
 
 
dtt2=zeros(1,1000);
 th1=0; 
for i=1:1000
    Z=Y((100*(i-1))+1);
    if (Z-th1>=0)
        
        dtt2(i)=1; 
    end
 
end
 
dtt2;
b2=0;
for i=1:1000
    if (S(i)-dtt2(i)==0)
     b2=b2+1;
    end
end
 
 
for i=1:1000
    if(S(i)==1)
        j1=j1+1;
        if(dtt2(i)==0)
            j2=j2+1;
        end
    end
end
j3=0;j4=0;
for i=1:1000
    if(S(i)==0)
        j3=j3+1;
        if(dtt2(i)==1)
            j4=j4+1;
        end
    end
end
p10=j2/j1
p01=j4/j3
lam1=p01;
lam0=p10;
 
i=1;
for k=0:0.1:1
    
    c1(i) = k*lam1 + (1-k)*lam0;
    c2(i) = k*(1-lam1) + (1-k)*(1-lam0);
    c3(i) = k;
    c4(i) = 1-k;
    i=i+1;  
end
figure
K=0:0.1:1;
plot(K,c1,'r');hold on;
plot(K,c2,'k');hold on;
plot(K,c3,'b');hold on;
plot(K,c4,'g');hold on;
r01 = (min(c4) - max(c4))/(min(c1) - max(c1) - max(c4) + min(c4)   )
Y1=[];
ro=(0-1)/(0.053-0.103-1+0)
for i=1:1000
    gg=rand(1);
   
    if(gg<r01)
       if (dtt2(i)==1)
          Y1(i)=1;
       else
           Y1(i)=0;
       end
    else
        Y1(i)=0;
    end
end
b3=0;
for i=1:1000
    if ( S(i)-Y1(i)==0  )
     b3=b3+1;
    end
end
b3;
figure
m2=sprintf('mini max technique binary channel model with detection rate = %d',(b3/100));
subplot(4,1,1);stem(X);title('Transmitted signal');xlabel('n(seconds)');ylabel('X[n]');
subplot(4,1,2);stem(Y);title('Received signal (AGN model)');xlabel('n(seconds)');ylabel('Y[n]');
subplot(4,1,3);stem(S);title('transmitted sequence ');xlabel('n(seconds)');ylabel('magnitude');
subplot(4,1,4);stem(Y1);title(m2);xlabel('n(seconds)');ylabel('magnitude');

