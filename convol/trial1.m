Fs = 16000;
M = length(xstudent);
N=length(hstudent);
m = 1:M;
X = fft(xstudent,M);
f = Fs*m/M;
subplot(3,1,1);
plot(f,abs(X)),title('fourier transform of x[n]');
xlabel('Hz');
ylabel('X(f)');
p=conv(xstudent,hstudent);
a=(M+N-1)/2; %length of y
for i=1:1:a
    y(i)=p(2*i);
end
Y = fft(y,a);
f = Fs*(1:a)/a;
subplot(3,1,2);
plot(f,abs(Y)),,title('fourier transform of y[n]');
xlabel('Hz');
ylabel('Y(f)');
q=conv(y,hstudent);
b=(a+N-1)/2; %length of y
for i=1:1:b
    z(i)=q(2*i);
end
Z = fft(z,b);
f = Fs*(1:b)/b;
subplot(3,1,3);
plot(f,abs(Z));
xlabel('Hz');
ylabel('Z(f)'),title('fourier transform of z[n]');
w = 0:0.01:(2*pi) ;

figure;
subplot(2,1,1);
plot(w,abs(fft(y,M)/fft(xstudent,M))) ;
title('Magnitude Response of the first stage');
xlabel('Frequency(Hz)');
ylabel('Magnitude');
subplot(2,1,2) ;
plot(w,angle(fft(y,M)/fft(xstudent,M))) ;
title('Phase Response of the first stage');
xlabel('Frequency(Hz)');
ylabel('Phase(radians)');
figure;
subplot(2,1,1);
plot(w,abs(fft(z,a)/fft(y,a))) ;
title('Magnitude Response of the second stage');
xlabel('Frequency(Hz)');
ylabel('Magnitude');
subplot(2,1,2) ;
plot(w,angle(fft(z,a)/fft(y,a))) ;
title('Phase Response of the second stage');
xlabel('Frequency(Hz)');
ylabel('Phase(radians)');






