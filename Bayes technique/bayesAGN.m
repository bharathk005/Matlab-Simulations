clc;
clear all;close all;
pi0=0.3;
x=rand(1,20000);s=[];
for i=1:20000
    if x(i)<=pi0
        s=[s -1];
    else
        s=[s 1];
    end
end
S=[];
for i=1:20000
    if s(i)==1
        S=[S ones(1,5)*5];
    else
        S=[S ones(1,5)*-5];
    end
            
end
n=sqrt(10).*randn(1,100000);
y=S+n;
figure;
subplot(2,1,1);stem(S(1:500));title('Transmitted signal(100000 sample)showing first 500samples');xlabel('samples');ylabel('vlaue');
subplot(2,1,2);plot(y);title('Received signal');xlabel('samples');ylabel('vlaue');
th=log(pi0/(1-pi0));
z=[];
for i=1:20000
    z=[z y((5*(i-1))+2)];
end
[p q]=find(z>=th);
adetect=ones(1,20000)*-1;
for i=1:1:length(p)
    adetect(q(i))=1;
end
[p1 q1]=find((adetect-s)==0);
adetectrate=(length(p1)*100)/length(s);



[p2 q2]=find(z>=0);
gdetect=ones(1,20000)*-1;
for i=1:1:length(p2)
    gdetect(q2(i))=1;
end
[p3 q3]=find((gdetect-s)==0);
gdetectrate=(length(p3)*100)/length(s);

M1=sprintf('Detected seq (threshold=0)showing first 500samples & detect rate- %d',gdetectrate);
M2=sprintf('Detected seq (bayes tecnique-AGN)showing first 500samples & detect rate- %d',adetectrate);

figure;
subplot(3,1,1);stem(s(1:500));title('Transmitted sequence(20000samples) showing first 500samples');xlabel('samples');ylabel('vlaue');
subplot(3,1,2);stem(gdetect(1:500));title(M1);xlabel('samples');ylabel('vlaue');
subplot(3,1,3);stem(adetect(1:500));title(M2);xlabel('samples');ylabel('vlaue');


