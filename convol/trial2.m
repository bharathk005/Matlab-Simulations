figure;
Fs = 16000;
M = length(xstudent);
N=  length(hstudent);
m = 1:M;
X = fft(xstudent,M);
%f = Fs*m/M;
subplot(3,1,1);
for i=1:100:M
d(i)=xstudent(i);
end
plot(d),title('x[n]');
xlabel('n');
ylabel('x[n]');
p=conv(xstudent,hstudent);
for i=1:1:((M+N-1)/2)
    y(i)=p(2*i);
end
L=length(y);
Y = fft(y,L);
%f = Fs*m/M;
subplot(3,1,2);
for i=1:100:L
e(i)=y(i);
end
plot(e),title('y[n]');
xlabel('n');
ylabel('y[n]');
q=conv(y,hstudent);
for i=1:1:((L+N-1)/2)
    z(i)=q(2*i);
end
Z = fft(z,(L+N-1)/2);
%f = Fs*m/M;
subplot(3,1,3);
for i=1:100:((L+N-1)/2)
v(i)=z(i);
end
plot(v),title('z[n]');
xlabel('n');
ylabel('z[n]');

