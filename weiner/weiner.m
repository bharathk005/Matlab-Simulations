f1=10;
f2=20;
Fs=100;
Ts=1/Fs;
n=1:1000;
X=sin(2*pi*f1*n*Ts)+sin(2*pi*f2*n*Ts);
N=sqrt(0.6).*randn(1,1000);
Y=X+N;
R=xcorr(Y);
gamma=xcorr(X,Y);
Rlen=zeros(1,1000);
for i=1000:1999
    Rlen(i-999)=R(i);
end
auto=zeros(1000,1000);
for i=1:1000
    for j=1:1000
        auto(i,j)=Rlen(abs(i-j)+1);
    end
end

Rprime=inv(auto);
gammalen=zeros(1,1000);
for i=1000:1999
    gammalen(i-999)=R(i);
end
h=zeros(1,1000);
h=Rprime*gammalen';
h1=h(1:11);
h2=h(1:101);

est1=conv(h1,Y);

est2=conv(h2,Y);
est=conv(h,Y);
fest1=abs(fft(est1));
fest2=abs(fft(est2));
fest=abs(fft(est));
sx=abs(fft(X));
figure;
subplot(3,1,1); plot(n*ts,X); title('Input Signal'); xlabel('time(s)'); ylabel('value');
subplot(3,1,2); plot(n*ts,Y); title('Corrupted Output Signal'); xlabel('time(s)'); ylabel('value');
subplot(3,1,3); plot(n*ts,N); title('Noise Signal'); xlabel('time(s)'); ylabel('value');
figure;
subplot(3,1,1); plot((1:1010)*0.2,est1); title('Filtered Signal, order 11'); xlabel('samples'); ylabel('Est1(n)');
subplot(3,1,2); plot(est2); title('Filtered Signal, order 101'); xlabel('samples'); ylabel('Est2(n)');
subplot(3,1,3); plot(est); title('Filtered Signal, order 1000'); xlabel('samples'); ylabel('Est(n)');
figure;
subplot(4,1,1); plot(fest1); title('Filtered Signal, order 11'); xlabel('samples'); ylabel('Est1(f)');
subplot(4,1,2); plot(fest2); title('Filtered Signal, order 101'); xlabel('samples'); ylabel('Est1(f)');
subplot(4,1,3); plot(fest); title('Filtered Signal, order 1000'); xlabel('samples'); ylabel('Est(f)');
subplot(4,1,4); plot(sx); title('Input Signal'); xlabel('samples'); ylabel('X');
