a1=50;
a2=100;
a4=20;
a3=40;
f1=100;f2=200;f3=1500;f4=300;
fs=5000;
ts=1/fs;
n=1:200;
x=a4*sin(2*pi*f4*n*ts)+a1*sin(2*pi*f1*n*ts)+a2*sin(2*pi*f2*n*ts)+a3*sin(2*pi*f3*n*ts);
s=a1*sin(2*pi*f1*n*ts)+a2*sin(2*pi*f2*n*ts);
noise=a3*sin(2*pi*f3*n*ts);

wc=(2*pi*1400*ts);
N=200;

for i=1:N
    if (i==(N+1)/2)
        hd(i)=wc/pi;
    else
        hd(i)=(wc/pi)*sin(wc*(i-(N+1)/2))/(wc*(i-(N+1)/2));
    end
end

h1=rectangular(hd);
h2=hanning(hd);
h3=hamming(hd);
h4=blackmann(hd);
h5=bartlett(hd);

H1=fft(h1);
H2=fft(h2);
H3=fft(h3);
H4=fft(h4);
H5=fft(h5);

h11=[H1(101:200) H1(1:100)];
h22=[H2(101:200) H2(1:100)];
h33=[H3(101:200) H3(1:100)];
h44=[H4(101:200) H4(1:100)];
h55=[H5(101:200) H5(1:100)];

m=-99:100;
f=n*fs/N;
k=m*fs/N; 

figure;
subplot(5,1,1);plot(k,abs(h11));xlabel('frequency(hz)');ylabel('amplitude');title('magnitude response of rectangular window(cutoff freq=1400Hz)   Fs=5000Hz');
subplot(5,1,2);plot(k,abs(h22));xlabel('frequency(hz)');ylabel('amplitude');title('magnitude response of hanning window(cutoff freq=1400Hz)      Fs=5000Hz');
subplot(5,1,3);plot(k,abs(h33));xlabel('frequency(hz)');ylabel('amplitude');title('magnitude response of hamming window(cutoff freq=1400Hz)      Fs=5000Hz');
subplot(5,1,4);plot(k,abs(h44));xlabel('frequency(hz)');ylabel('amplitude');title('magnitude response of blackmann window(cutoff freq=1400Hz)     Fs=5000Hz');
subplot(5,1,5);plot(k,abs(h55));xlabel('frequency(hz)');ylabel('amplitude');title('magnitude response of bartlett window(cutoff freq=1400Hz)       Fs=5000Hz');

figure;
subplot(5,1,1);plot(k,angle(h11));xlabel('frequency(hz)');ylabel('phase');title('phase response of rectangular window(cutoff freq=1400Hz)   Fs=5000Hz');
subplot(5,1,2);plot(k,angle(h22));xlabel('frequency(hz)');ylabel('phase');title('phase response of hanning window(cutoff freq=1400Hz)   Fs=5000Hz');
subplot(5,1,3);plot(k,angle(h33));xlabel('frequency(hz)');ylabel('phase');title('phase response of hamming window(cutoff freq=1400Hz)   Fs=5000Hz');
subplot(5,1,4);plot(k,angle(h44));xlabel('frequency(hz)');ylabel('phase');title('phase response of blackmann window(cutoff freq=1400Hz)   Fs=5000Hz');
subplot(5,1,5);plot(k,angle(h55));xlabel('frequency(hz)');ylabel('phase');title('phase response of bartlett window(cutoff freq=1400Hz)   Fs=5000Hz');

y1=conv(x,h1);
y2=conv(x,h2);
y3=conv(x,h3);
y4=conv(x,h4);
y5=conv(x,h5);

figure;
subplot(4,2,1);plot(n*ts,x);xlabel('time in sec');ylabel('amplitude');title('signal x');
subplot(4,2,3);plot(n*ts,s);xlabel('time in sec');ylabel('amplitude');title('signal s');
subplot(4,2,5);plot(n*ts,noise);xlabel('time in sec');ylabel('amplitude');title('signal noise');
n1= 1:length(y1);
subplot(4,2,7);plot(n1*ts,y1);xlabel('time in sec');ylabel('amplitude');title('Filtered signal using rectangular window');
subplot(4,2,2);plot(n1*ts,y2);xlabel('time in sec');ylabel('amplitude');title('Filtered signal using hanning window');
subplot(4,2,4);plot(n1*ts,y3);xlabel('time in sec');ylabel('amplitude');title('Filtered signal using hamming window');
subplot(4,2,6);plot(n1*ts,y4);xlabel('time in sec');ylabel('amplitude');title('Filtered signal using blackmann window ');
subplot(4,2,8);plot(n1*ts,y5);xlabel('time in sec');ylabel('amplitude');title('Filtered signal using bartlett window');

X=fft(x);X=[X(101:200) X(1:100)];
S=fft(s);S=[S(101:200) S(1:100)];
Y1=fft(y1);Y1=[Y1(201:399) Y1(1:200)];
Y2=fft(y2);Y2=[Y2(201:399) Y2(1:200)];
Y3=fft(y3);Y3=[Y3(201:399) Y3(1:200)];
Y4=fft(y4);Y4=[Y4(201:399) Y4(1:200)];
Y5=fft(y5);Y5=[Y5(201:399) Y5(1:200)];

figure;
subplot(4,2,1);plot((-100:99)*(fs)*(1/200),abs(X));xlabel('frequency(hz)');ylabel('amplitude');title('magnitude response of x   Fs=5000Hz');
subplot(4,2,2);plot((-99:100)*(fs)*(1/200),abs(S));xlabel('frequency(hz)');ylabel('amplitude');title('magnitude response of s   Fs=5000Hz');
subplot(4,2,3);plot((-199:199)*(fs)*(1/399),abs(Y1));xlabel('frequency(hz)');ylabel('amplitude');title('magnitude response of y1(output of rectangular window)   Fs=5000Hz');
subplot(4,2,4);plot((-199:199)*(fs)*(1/399),abs(Y2));xlabel('frequency(hz)');ylabel('amplitude');title('magnitude response of y2(output of hanning window)   Fs=5000Hz');
subplot(4,2,5);plot((-199:199)*(fs)*(1/399),abs(Y3));xlabel('frequency(hz)');ylabel('amplitude');title('magnitude response of y3(output of hamming window)   Fs=5000Hz');
subplot(4,2,6);plot((-199:199)*(fs)*(1/399),abs(Y4));xlabel('frequency(hz)');ylabel('amplitude');title('magnitude response of y4(output of blackmann window)   Fs=5000Hz');
subplot(4,2,7);plot((-199:199)*(fs)*(1/399),abs(Y5));xlabel('frequency(hz)');ylabel('amplitude');title('magnitude response of y5(output of bartlett window)   Fs=5000Hz');














