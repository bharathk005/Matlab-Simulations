clear all;
clc;
prompt='give the number';
n=input(prompt);
m=1;
i=1;
k(n)=0;
while(n>=m)
    if(rem(n,m)==0)
        k(i)=m;
        i=i+1;
  
  
    end
m=m+1;
end
c=sum(k)/2;
if(c==n)
    display('perfect number');
else display('not a perfect number');

end
