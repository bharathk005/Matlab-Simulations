r1=[0 0 0 0 3 7 6 0 0];
r2=[0 0 0 6 0 0 0 9 0];
r3=[0 0 8 0 0 0 0 0 4];

r4=[0 9 0 0 0 0 0 0 1];
r5=[6 0 0 0 0 0 0 0 9];
r6=[3 0 0 0 0 0 0 4 0];


r7=[7 0 0 0 0 0 8 0 0];
r8=[0 1 0 0 0 9 0 0 0];
r9=[0 0 2 5 4 0 0 0 0];


s=vertcat(r1,r2,r3,r4,r5,r6,r7,r8,r9);
su = s;
st = s;
z=0;


for b=1:50
for i=1:9
   for j=1:9
       for k=1:9
           if(st(j,k) == i)
                st(:,k)= -1;
                st(j,:)=-1;
               
                if(j<4)
                    if(k<4)
                        p1=1;
                        p2=1;
                    end
                    
                    if(k>3 && k<7)
                        p1=1;
                        p2=4;
                    end
                    
                    if(k>6 && k<10)
                        p1=1;
                        p2=7;
                    end
                end
                
                if(j>3 && j<7)
                    if(k<4)
                       p1=4;
                       p2=1;
                    end
                    
                    if(k>3 && k<7)
                        p1=4;
                        p2=4;
                    end
                    
                    if(k>6 && k<10)
                        p1=4;
                        p2=7;
                    end
                end
                
                if(j<10 && j>6)
                    if(k<4)
                        p1=7;
                        p2=1;
                    end
                    
                    if(k>3 && k<7)
                        p1=7;
                        p2=4;
                    end
                    
                    if(k>6 && k<10)
                        p1=7;
                        p2=7;
                    end
                end
                
                for m=p1:(p1+2)
                   for n=p2:(p2+2)
                       st(m,n)=-1; 
                   end
                end
                
            end
            
       end
   end
   
    for p=1:3:7
        for q=1:3:7
                        for x=p:(p+2)
                            for y= q:(q+2)
                                if(st(x,y)==0)
                                    z=z+1;
                                    x1=x;
                                    y1=y;
                                end
                            end
                        end
                    
                        if(z==1)
                            s(x1,y1)=i;
                        end
                        z=0;
         end
                            
    end
   
    st=s;
   
   
end
end











