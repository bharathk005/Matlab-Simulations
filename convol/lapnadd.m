function y = lapnadd(x,h)

LMax=length(x);
M=length(h);
L=M;
N= L+M-1;

n = ceil(LMax/L);

y = zeros(1,LMax+M-1);

    start = 1;
    stop = L;
    x1 = x(start:stop);
    y1 = convol( x1,h );
    y(1:N) = y1;
    
for i=2:n
   
    start = L*(i-1)+1;
    stop = L*i;
    x1 = x(start:stop);
    y1 = convol( x1,h );
    a=start;
    b=start+N-1;
    y(a:b) = y(a:b)+ y1;
    
end





end