hold on
scatter(rand(1,4)*10,rand(1,4)*10,500,'m','fill');
cp=['g' 'b' 'c' 'k' 'r'];
start=rand(1,1);
endp=[9 9];
for i=1:5
    x=[start x(i)+rand(1,5)*10 endp];
    y=[start y(i)+rand(1,5)*10 endp];
    plot(x,y,cp(i),'linewidth',0.5);
    text(x,y,'q');
    
 
end
legend('radar','2','3','4','5',0)
hold off
grid on