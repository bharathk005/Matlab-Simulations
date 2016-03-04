clear all,close all
a1=20;a2=30;a3=5;f1=50;f2=60;f3=650;fs=1500;ts=1/fs;n=1:200;
s=a1*sin(2*pi*n*f1*ts)+a2*sin(2*pi*n*f2*ts);
x=s+a3*sin(2*pi*n*f3*ts);
figure;
subplot(3,1,1),plot(n*ts,s),title('input signal without noise     fs=1500hz'),xlabel('time(sec)'),ylabel('s[n]');
subplot(3,1,2),plot(n*ts,x),title('input signal with noise'),xlabel('time(sec)'),ylabel('x[n]');
X=fft(x);N=200;
X=[X((N/2)+1:N) X(1:N/2)];
subplot(3,1,3),plot((-(N/2):(N/2)-1)*fs/N,abs(X)),title('magnitude response of input signal with noise'),xlabel('frequency(hz)'),ylabel('|X[f]|');
f=n*fs/N;
wc=2*pi*400/fs;
y(1)=0;y(2)=0;y(3)=0;
x=[0 0 0 x];
for i=1:N
    y(i+3)=(1.38996*x(i+3)+4.169898*x(i+2)+4.169898*x(i+1)+1.38996*x(i)-1.35537*y(i+2)-2.24153*y(i+1)-0.21419*y(i))/7.05803;
end
y=y(4:N+3);
figure;
subplot(2,1,1),plot(n*ts,y),title('filtered signal using butterworth filter of cutoff 400hz using BILINEAR TRANSFORMATION'),xlabel('time(sec)'),ylabel('y[n]');
Y=fft(y);
Y=[Y((N/2)+1:N) Y(1:N/2)];
subplot(2,1,2),plot((-(N/2):(N/2)-1)*fs/N,abs(Y)),title('magnitude response of filtered signal using BILINEAR TRANSFORMATION'),xlabel('frequency(hz)'),ylabel('|Y[f]|');
a=[1.38996 4.169898 4.169898 1.38996];
b=[7.05803 1.35537 2.24153 0.21419];
[h,w]=freqz(a,b,'whole',1500);
a=h(1:750,1);b=h(751:1500,1);
i=1:750;
c(1,i)=a(i,1);d(1,i)=b(i,1);
H=[d c];
figure;
subplot(2,1,1),plot((-750:749),abs(H)),title('Magnitude response of BUTTERWORTH filter using BILINEAR TRANSFORMATION---cutoff 400hz'),xlabel('frequency(hz)'),ylabel('|H[f]|');
subplot(2,1,2),plot((-750:749),phase(h)),title('Phase response of BUTTERWORTH filter using BILINEAR TRANSFORMATION---cutoff 400hz'),xlabel('frequency(hz)'),ylabel('phase of H');



%impulse invariance
y1(1)=0;y1(2)=0;
x=[0 0 x];j=sqrt(-1);Wc=2*pi*200;
for i=1:N
    y1(i+2)=0.43366*x(i+1)+0.91755*y1(i+1)-0.30582*y1(i);
end
y1=y1(3:N+2);
figure;
subplot(2,1,1),plot(n*ts,y1),title('filtered signal using butterworth filter of cutoff 400hz using IMPULSE INVARIANCE TECHNIQUE'),xlabel('time(sec)'),ylabel('y1[n]');
Y1=fft(y1);
Y1=[Y1((N/2)+1:N) Y1(1:N/2)];
subplot(2,1,2),plot((-(N/2):(N/2)-1)*fs/N,abs(Y1)),title('magnitude response of filtered signal using IMPULSE INVARIANCE TECHNIQUE'),xlabel('frequency(hz)'),ylabel('|Y1[f]|');
a=[0 0.43366 0];b=[1 -0.91755 0.30582];
[h,w]=freqz(a,b,'whole',1500);
a=h(1:750,1);b=h(751:1500,1);
i=1:750;
c(1,i)=a(i,1);d(1,i)=b(i,1);
H=[d c];
figure;
subplot(2,1,1),plot((-750:749),abs(H)),title('Magnitude response of BUTTERWORTH filter using IMPULSE INVARIANCE TECHNIQUE---cutoff 200hz'),xlabel('frequency(hz)'),ylabel('|H[f]|');
subplot(2,1,2),plot((-750:749),phase(h)),title('Phase response of BUTTERWORTH filter using IMPULSE INVARIANCE TECHNIQUE---cutoff 200hz'),xlabel('frequency(hz)'),ylabel('phase of H');