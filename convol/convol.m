function z = convol(x,h)
L=length(x);
M=length(h);
N= L+M-1;

x = [x zeros(1,M-1)];
h = [h zeros(1,L-1)];

X = fft(x);
H = fft(h);

Y = X.*H;

z = ifft(Y);

end