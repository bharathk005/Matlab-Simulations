clear all;
clc;
a=imread('img4.jpg');
b=imread('img41.jpg');
c=b-a;
t(1440,2560,3)=0;
for i=1:1440
    for j=1:2560
        if(c([i j 1])>0)
           t([i j 1])=255;
        end
        if(c([i j 2])>0)
           t([i j 2])=255;
        end
        if(c([i j 3])>0)
           t([i j 3])=255;
        end
    end
    
end
imshow(t);
