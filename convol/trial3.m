Fs = 16000;
M = length(hstudent);
m = 0:M-1;
H = fft(hstudent,M);
f = Fs*m/M;
figure;
plot(f,abs(H)),title('Transfer characterstics of LPDF');
xlabel('Hz');
ylabel('H(f)');

