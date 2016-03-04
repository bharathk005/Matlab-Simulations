data=[zeros(1,64) DATA zeros(1,63)];
for i=1:1:64
    for j=1:1:147
        b=[zeros(1,j) B(i,:) zeros(1,147-j)];
        c(i,j)=b*data';
    end
end
for i=0:1:7    
  figure;
        for j=8*i+1:1:8*(i+1)
              r=1:147;
              subplot(2,4,j-(8*i));
              plot(r,c(j,:));
              title(j);
              xlabel('n');
              ylabel('correlation value');
        end
end
