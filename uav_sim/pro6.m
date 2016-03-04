start=rand(1);endp=[9 9 9];
Qo=0;L=0.5;D=0.5;m=0;t=0;d=0;

hold on;
r1=rand(1,3)*10;
r2=rand(1,3)*9;
r3=rand(1,3)*7;
r4=rand(1,3)*5;
r5=rand(1,3)*3;
R1=scatter3(r1(1),r1(2),r1(3),1000,'y','fill');
R2=scatter3(r2(1),r2(2),r2(3),1000,'y','fill');
R3=scatter3(r3(1),r3(2),r3(3),1000,'y','fill');
R4=scatter3(r4(1),r4(2),r4(3),1000,'y','fill');
R5=scatter3(r5(1),r5(2),r5(3),1000,'y','fill');
axis([0 12 0 12 0 12]);
whitebg([0 .5 .7]);
pause(4);

cx=start;cy=start;cz=start;
tic;
while(cx<=endp(1) || cy<=endp(2))
  x=cx+(rand(1,100)*0.5);
  y=cy+(rand(1,100)*0.5);
  z=cz+(rand(1,100)*0.5);  
    if(t==5)
      delete(R1,R2,R3,R4,R5);
      
      
      r1=r1-rand(1,3)*0.5;
      r2=r2-rand(1,3)*0.5;
      r3=r3+rand(1,3)*0.5;
      r4=r4+rand(1,3)*0.5;
      r5=r5+rand(1,3)*0.5;
      R1=scatter3(r1(1),r1(2),r1(3),1000,'y','fill');
      R2=scatter3(r2(1),r2(2),r2(3),1000,'y','fill');
      R3=scatter3(r3(1),r3(2),r3(3),1000,'y','fill');
      R4=scatter3(r4(1),r4(2),r4(3),1000,'y','fill');
      R5=scatter3(r5(1),r5(2),r5(3),1000,'y','fill');
      
      pause(0.5);
      
      t=0;
    end
    
   t=t+1;
    

dr1x=abs((r1(1)-x));  dr1y=abs((r1(2)-y));  dr1z=abs((r1(3)-z));
dr2x=abs((r2(1)-x));  dr2y=abs((r2(2)-y));  dr2z=abs((r2(3)-z));
dr3x=abs((r3(1)-x));  dr3y=abs((r3(2)-y));  dr3z=abs((r3(3)-z));
dr4x=abs((r4(1)-x));  dr4y=abs((r4(2)-y));  dr4z=abs((r4(3)-z));
dr5x=abs((r5(1)-x));  dr5y=abs((r5(2)-y));  dr5z=abs((r5(3)-z));

R=dr1x+dr1y+dr1z+dr2x+dr2y+dr2z+dr3x+dr3y+dr3z+dr4x+dr4y+dr4z+dr5x+dr5y+dr5z;

dex=abs((endp(1)-x));    dey=abs((endp(2)-y));     dez=abs((endp(3)-z));
E=dex+dey+dez;

Qn=Qo+L*((-1*E)+(D*m)-Qo)+R;   
m=max(Qn);
h=find(Qn==m);

   if(dr1x(h)<1.5||dr2x(h)<1.5||dr3x(h)<1.5||dr4x(h)<1.5||dr5x(h)<1.5||dr1y(h)<1.5||dr2y(h)<1.5||dr3y(h)<1.5||dr4y(h)<1.5||dr5y(h)<1.5||dr1z(h)<1.5||dr2z(h)<1.5||dr3z(h)<1.5||dr4z(h)<1.5||dr5z(h)<1.5)
      Qn(h)=min(Qn);
      m=max(Qn);
      h=find(Qn==m);
   end
ni=x(h);nj=y(h);nk=z(h);
X=[ni cx];Y=[nj cy];Z=[nk cz];
d=d+sqrt(((ni-cx).^2)+((nj-cy).^2)+((nk-cz).^2));

plot3(X,Y,Z,'g','linewidth',2);
text(X,Y,Z,'');
grid on;
xlabel('x axis');
ylabel('y axis');
zlabel('z axis');
cx=ni; cy=nj; cz=nk;
Qo=Qn;


end
disp('the time taken is =');
disp(toc);
disp('distance travelled=');
disp(d);
disp('displacement=');
dp=sqrt(((start-cx).^2)+((start-cy).^2)+((start-cz).^2));
disp(dp);
e=(dp/d)*100;
disp('efficiency=');
disp(e);
disp('total altitude gained=');
al=cz-start;
disp(al);


pause(0.5);
legend('path',0);
hold off;


