function [h]=hamming(hd)

n=length(hd);
w=0.54+0.46*cos(2*pi*((0:n-1)-(n+1)/2)/(n-1));
h=w.*hd;
end

