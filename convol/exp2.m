function exp2

f1 = 10;
f2 = 20;
f3 = 30;
f4 = 40;
f5 = 50;
fs = 200;
ts = 1/fs;

n = 1:100;
x1 = sin(2*pi*ts*n*f1);
x2 = sin(2*pi*ts*n*f2);
x3 = sin(2*pi*ts*n*f3);
x4 = sin(2*pi*ts*n*f4);
x5 = sin(2*pi*ts*n*f5);

x=x1+x2+x3+x4+x5;

h1 = [-0.0011 0.0048 0.0006 -0.0316 0.0275 -0.1298 -0.2263 +0.3153 0.7511 0.4946 0.1115];
y1 = zeros(1,(length(x)+length(h1)-1));
y1 = lapnadd(x,h1);
y2 = y1;
for i = 1:2:length(y1)
        y2(i) = 0;
end

h2 = [-0.1115 0.4946 -0.7511 0.315 0.2263 -0.1298 -0.0975 0.0275 0.0316 0.0006 -0.0048 -0.0011];
y3 = zeros(1,(length(x)+length(h2)-1));
y3 = lapnadd(x,h2);
y4 = y3;
for i = 1:2:length(y3)
        y4(i) = 0;
end

h3 = [0.1115 0.4946 0.7511 0.315 -0.2263 -0.1298 -0.0975 0.0275 -0.0316 0.0006 0.0048 -0.0011];

out1 = zeros(1,(length(y2)+length(h3)-1));
out1 = lapnadd(y2,h3);

h4 = [-0.0011 -0.0048 0.0006 0.0316 0.0275 -0.0975 -0.1298 0.2263 +0.3153 -0.7511 0.4946 -0.1115];

out2 = zeros(1,(length(y4)+length(h4)-1));
out2 = lapnadd(y4,h4)

out = out1+out2;

n=n/fs;
subplot(2,1,1), plot(n,x), title('s[n]'),xlabel('Time(sec)');
subplot(2,1,2),plot(n,y),title('y[n]'),xlabel('Time(sec)');
end