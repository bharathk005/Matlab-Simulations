clc
close all
clear all
cc=[];
x=rand(1,20000);s=[];pi0=0.3;
for i=1:20000
    if x(i)<pi0
        s=[s -1];
    else
        s=[s 1];
    end
end
[p q]=find((s-1)==0);
display(length(p));
display(length(s)-length(p));
S=[];
for i=1:20000
    if s(i)==1
        S=[S ones(1,5)*5];
    else
        S=[S ones(1,5)*-5];
    end
            
end


N=sqrt(10).*randn(1,100000);
y=S+N;
figure;
subplot(2,1,1);stem(S(1:500));title('Transmitted signal(100000 sample)showing first 500samples');xlabel('samples');ylabel('vlaue');
subplot(2,1,2);stem(y(1:500));title('Received signal');xlabel('samples');ylabel('vlaue');
z=[];
for i=1:20000
    z=[z y(5*(i-1)+3)];
end
gdetect=ones(1,20000)*-1;
[p1 q1]=find(z>0);
for i=1:1:length(p1)
    gdetect(q1(i))=1;
end

[p2 q2]=find((gdetect-s)==0);
gdetectrate=(length(p2)*100)/length(s);
cc=[cc gdetectrate];

p11=0;p10=0;
[p3 q3]=find(s==1);
for i=1:1:length(p3)
    if gdetect(q3(i))==1
        p11=p11+1;
    else
        p10=p10+1;
    end
end
prob11=p11/length(p3);
prob10=p10/length(p3);


p01=0;p00=0;
[p4 q4]=find(s==-1);
for i=1:1:length(p4)
    if gdetect(q4(i))==-1
        p00=p00+1;
    else
        p01=p01+1;
    end
end
prob00=p00/length(p4);
prob01=p01/length(p4);
c1=prob01*pi0+prob10*(1-pi0);
c2=(1-prob01)*pi0+(1-prob10)*(1-pi0);
c3=pi0;
c4=(1-pi0);
c=[c1 c2 c3 c4];
display(c);
cost=min(c);
[p5 q5]=find(c==cost);
bdetect=gdetect;
switch q5
    case 1
        bdetectrate=gdetectrate;
    case 2
        for i=1:1:length(bdetect)
            if bdetect(i)==1
                bdetect(i)=-1;
            else
                bdetect(i)=1;
            end
        end
        [p6 q6]=find((bdetect-s)==0);
        bdetectrate=(length(p6)*100)/length(s);
    case 3
        for i=1:1:length(bdetect)
            bdetect(i)=1;
        end
        [p7 q7]=find((bdetect-s)==0);
        bdetectrate=(length(p7)*100)/length(s);
    case 4
        for i=1:1:length(bdetect)
            bdetect(i)=-1;
        end
        [p8 q8]=find((bdetect-s)==0);
        bdetectrate=(length(p8)*100)/length(s);
end
display(bdetectrate);

        
        
            
 

j=sprintf('Detected seq (threshold=0)showing first 500samples & detect rate- %d',gdetectrate);
j1=sprintf('Detected seq (bayes tecnique-binary channel)showing first 500samples & detect rate- %d',bdetectrate);
figure;
subplot(3,1,1);stem(s(1:500));title('Transmitted sequence(20000samples) showing first 500samples');xlabel('samples');ylabel('vlaue');
subplot(3,1,2);stem(gdetect(1:500));title(j);xlabel('samples');ylabel('vlaue');
subplot(3,1,3);stem(bdetect(1:500));title(j1);xlabel('samples');ylabel('vlaue');






