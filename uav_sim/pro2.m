start=rand(1);endp=[9 9 9];
hold on
r1=rand(1,3)*5;
r2=rand(1,3)*5;
r3=rand(1,3)*5;
r4=rand(1,3)*5;
scatter3(r1(1),r1(2),r1(3),1000,'m','fill');
scatter3(r2(1),r2(2),r2(3),1000,'m','fill');
scatter3(r3(1),r3(2),r3(3),1000,'m','fill');
scatter3(r4(1),r4(2),r4(3),1000,'m','fill');

cx=start;cy=start;cz=start;

while(cx<=endp(1))
x=cx+(rand(1,100)*0.5);
y=cy+(rand(1,100)*0.5);
z=cz+(rand(1,100)*0.5);
dr1x=abs((r1(1)-x));  dr1y=abs((r1(2)-y));  dr1z=abs((r1(3)-z));
dr2x=abs((r2(1)-x));  dr2y=abs((r2(2)-y));  dr2z=abs((r2(3)-z));
dr3x=abs((r3(1)-x));  dr3y=abs((r3(2)-y));  dr3z=abs((r3(3)-z));
dr4x=abs((r4(1)-x));  dr4y=abs((r4(2)-y));  dr4z=abs((r4(3)-z));
R=dr1x+dr1y+dr1z+dr2x+dr2y+dr2z+dr3x+dr3y+dr3z+dr4x+dr4y+dr4z;

dex=abs((endp(1)-x));    dey=abs((endp(2)-y));     dez=abs((endp(3)-z));
E=dex+dey+dez;

Q=R-E;
m=max(Q);
h=find(Q==m);

   if(dr1x(h)<1||dr2x(h)<1||dr3x(h)<1||dr4x(h)<1||dr1y(h)<1||dr2y(h)<1||dr3y(h)<1||dr4y(h)<1||dr1z(h)<1||dr2z(h)<1||dr3z(h)<1||dr4z(h)<1)
      Q(h)=min(Q);
      m=max(Q);
      h=find(Q==m);
   end
ni=x(h);nj=y(h);nk=z(h);

X=[ni cx];Y=[nj cy];Z=[nk cz];
plot3(X,Y,Z,'y','linewidth',2);
text(X,Y,Z,'Q');
grid on;
xlabel('x axis');
ylabel('y axis');
zlabel('z axis');
cx=ni; cy=nj; cz=nk;
display(Q);
display(m);

end

legend('radar',0);
hold off;


