function z= recursivedit(f,N)
    F=zeros(N);
    if N==1
        z=f;
    else
        N1=N/2;
        for n1=0:N1-1
            fe(n1+1)=f(2*n1+1);
            fo(n1+1)=f(2*n1+2);
        end
        Fe=recursivedit(fe,N1);
        Fo=recursivedit(fo,N1);
        for k=0:N1-1
            x=Fo(k+1)*expo(N,k);
            F(k+1)=Fe(k+1)+x;
            F(k+N1+1)=Fe(k+1)-x;
        end
        z=F;
    end           

end