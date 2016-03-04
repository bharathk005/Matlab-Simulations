function [h]=bartlett(hd)

n=length(hd);
w=1-2*abs((0:n-1)-(n+1)/2)/(n-1);
h=w.*hd;
end