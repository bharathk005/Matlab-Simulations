function [h]=blackmann(hd)

n=length(hd);
w=0.42+0.50*cos(2*pi*((0:n-1)-(n+1)/2)/(n-1))+0.08*cos(4*pi*((0:n-1)-(n+1)/2)/(n-1));
h=w.*hd;
end