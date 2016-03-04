start=rand(1);
hold on
scatter3(rand(1,4)*10,rand(1,4)*10,rand(1,4)*10,500,'m','fill');

cp=['g' 'b' 'c' 'k' 'r'];

endp=9;
for i=1:5
    x=[start x(i)+rand(1,5) endp];
    y=[start y(i)+rand(1,5) endp];
    z=[start z(i)+rand(1,5) endp];
    plot3(x,y,z,cp(i),'linewidth',0.5);
    text(x,y,z,'q');
end
legend('radar','2','3','4','5',0)
hold off
grid on