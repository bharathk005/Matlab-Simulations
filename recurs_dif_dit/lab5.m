f1=10;  f2=20;  f3=100;
fs=500; ts=1/fs;

n=1:1024;
f=10*sin(2*pi*f1*n*ts)+20*sin(2*pi*f2*n*ts)+sin(2*pi*f3*n*ts);
figure(1);
plot(n*ts,f); title('time domain signal'); xlabel('time(sec)'); ylabel('amplitude');

N=1024;
z1=recursivedif2(f,N);
z2=recursivedit(f,N);
z3=fft(f,N);
figure(2);
subplot(3,1,1)
plot(abs(z1));
xlabel('time(sec)'); ylabel('z1');

subplot(3,1,2)
plot(abs(z2));
xlabel('time(sec)'); ylabel('z2');

subplot(3,1,3) 
plot(abs(z3));
xlabel('time(sec)'); ylabel('z3');
