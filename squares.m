%! Example of creating a movie (avi) file from a series of plots
% University of Tennessee : Will Schleter
 
function create_animation()
 
clear all;
clc;
close all;
 
x=[0,2,3,4,5,6,8];
y=[0,2,3,4,5,6,8];
figure(1);
sketchgrid;
h=msgbox('This example creates an animation showing the number squares in this diagram.');
uiwait(h);
cnt=0;
filename='example.avi';
mov = avifile(filename,'compression','none','fps',6)
for ix1=1:1:6
    for iy1=1:1:6
        iy2=iy1;
        for ix2=ix1+1:7
            d = x(ix2)-x(ix1);
            %check 3rd point
            y3=y(iy2)+d;
            if find(y==y3)
                cnt = cnt + 1;
                xx=[x(ix1) x(ix2) x(ix2) x(ix1) x(ix1)];
                clf reset;
                yy=[y(iy1) y(iy2) y3 y3 y(iy1)];
                patch(xx,yy,'-');
                text(mean(xx),mean(yy),num2str(cnt));
                sketchgrid;
                mov = addframe(mov,getframe)
                % pause
            end
        end
    end
end
mov = close(mov);
msgbox([filename ' has been created in the current directory.']);
web(filename,'-browser');
 
function sketchgrid
    hold on;
    plot([0 0],[0 8],'k-')
    plot([2 2],[0 8],'k-')
    plot([3 3],[0 8],'r-')
    plot([4 4],[0 8],'k-')
    plot([5 5],[0 8],'r-')
    plot([6 6],[0 8],'k-')
    plot([8 8],[0 8],'k-')
     
    plot([0 8],[0 0],'k-')
    plot([0 8],[2 2],'k-')
    plot([0 8],[3 3],'r-')
    plot([0 8],[4 4],'k-')
    plot([0 8],[5 5],'r-')
    plot([0 8],[6 6],'k-')
    plot([0 8],[8 8],'k-')
     
    axis square;
    axis([-1 9 -1 9]);
return
