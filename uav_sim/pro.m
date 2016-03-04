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
dr1x=(r1(1)-x).^2;  dr1y=(r1(2)-y).^2;  dr1z=(r1(3)-z).^2;
dr2x=(r2(1)-x).^2;  dr2y=(r2(2)-y).^2;  dr2z=(r2(3)-z).^2;
dr3x=(r3(1)-x).^2;  dr3y=(r3(2)-y).^2;  dr3z=(r3(3)-z).^2;
dr4x=(r4(1)-x).^2;  dr4y=(r4(2)-y).^2;  dr4z=(r4(3)-z).^2;
R=dr1x+dr1y+dr1z+dr2x+dr2y+dr2z+dr3x+dr3y+dr3z+dr4x+dr4y+dr4z;

dex=(endp(1)-x).^2;    dey=(endp(2)-y).^2;     dez=(endp(3)-z).^2;
E=dex+dey+dez;

Q=R-E;
m=max(Q);
h=find(Q==m);
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


