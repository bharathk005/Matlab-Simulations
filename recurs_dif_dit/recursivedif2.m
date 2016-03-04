function z= recursivedif2(f,N)

F=zeros(N);
if N==1
    z=f;
else
    N1=N/2;
    for n=0:N1-1
        fe(n+1)=f(n+1)+f(n+1+N1);
        fo(n+1)=(f(n+1)-f(n+1+N1))*expo(N,n);
    end
    
    Fe=recursivedif2(fe,N1);
    Fo=recursivedif2(fo,N1);
    
    for k1=0:N1-1 
        F(2*k1+1)=Fe(k1+1);
        F(2*k1+2)=Fo(k1+1);
    end
    z=F;
end
    
end