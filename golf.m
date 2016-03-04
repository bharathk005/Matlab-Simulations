%! Engage golf ball gun analysis/simulator
%! A GUI for setting parameters and displaying results of a 'shooter'
% University of Tennessee : Will Schleter
 
function main
global gAngle gSpring gStiff gBallMass gCarriageMass gY0 gExitFlag gXtarg gYtarg gAir gEff;
 
gSpring = 6;
gAngle = 30;
gExitFlag = 0;
gXtarg = 200;
gYtarg = 15;
gAir = 0;
gEff = 100;
gY0 = 28;
gBallMass = 45;
gCarriageMass = 45;
gStiff = .55;
 
initUI;
 
UpdatePlot;
 
%infinite loop to allow for animation
while (~gExitFlag)
    pause(0.1); %must use pause to provide for screen updates
end
 
close(2);
 
return
 
function UpdatePlot
global gAngle gSpring gStiff gBallMass gCarriageMass gY0 gExitFlag gXtarg gYtarg gAir gEff;
 
i2m = 25.4/1000;
m2i = 1000/25.4;
m2i = 1/i2m;
d2r = pi/180;
g = 9.81;
p2n = 4.44822170;
n2p = 1/p2n;
ips2mph = 3600/(12*5280);
del0 = .5*i2m; %spring extension at release
 
m = ( gCarriageMass + gBallMass)/1000 %kg
 
del = gSpring*i2m; %m
th = gAngle*d2r; %radians
f = gEff/100; %%%%*p2n;
a = gAir*50;
 
%adjust for release point offset from origin point
y0 = gY0 + 22.75 - (3.75 * sin(th))
x0 = 5 + 3.75 * cos(th);
%convert to meters
x0 = x0 * i2m;
y0 = y0*i2m; 
 
k = gStiff*p2n/i2m;
 
 
%update the angle box and slider with the current value
set(findobj('Tag','SpringSlider'),'Value',gSpring);
set(findobj('Tag','SpringValue'),'String',num2str(gSpring));
set(findobj('Tag','AngleSlider'),'Value',gAngle);
set(findobj('Tag','AngleValue'),'String',num2str(gAngle));
set(findobj('Tag','StiffSlider'),'Value',gStiff);
set(findobj('Tag','StiffValue'),'String',num2str(gStiff));
set(findobj('Tag','HeightSlider'),'Value',gY0);
set(findobj('Tag','HeightValue'),'String',num2str(gY0));
set(findobj('Tag','EffSlider'),'Value',gEff);
set(findobj('Tag','EffValue'),'String',num2str(gEff));
set(findobj('Tag','AirSlider'),'Value',gAir);
set(findobj('Tag','AirValue'),'String',num2str(gAir));
 
 
%v0 = sqrt(2.*k.*(del.*del - del0.*del0)./m -  2.*g.*(del-del0).*sin(th) - 2.*f.*(del-del0)./m);
v0sq = 2.*k.*(del.*del - del0.*del0)./m -  2.*g.*(del-del0).*sin(th);
v0sq = v0sq .* f;
v0 = sqrt(v0sq);
 
yp = [ -g./2 v0.*sin(th) y0 ];
 
thit = max(roots(yp))
xhit = v0.*cos(th).*thit;
 
thit = thit + 0.1;
 
tt = linspace(0,thit,1000);
xx = v0.*cos(th).*tt - x0;
yy = polyval(yp,tt);
 
len = length(xx);
for i2=2:len
   i1 = i2-1;
   dx = xx(i2)-xx(i1);
    dy = yy(i2)-yy(i1);
   d = sqrt(dx^2 + dy^2);
   xf = a * d^2 * dx / d;
   yf = a * d^2 * dy / d;
   xx(i2:len) = xx(i2:len) - xf;
   yy(i2:len) = yy(i2:len) - yf;
   if (yy(i2)<0)
      len=i1;
      break;
   end
end
 
xx = xx(1:len);
yy = yy(1:len);
xhit = xx(len);
    
%axis manual;
plot(xx*m2i,yy*m2i);
axis([-10 300 0 120]);
axis equal;
axis manual;
hold on;
%plot(gXtarg,gYtarg,'r*');
xlabel('Distance (in)');
ylabel('Height (in)');
title('engage Golf Ball Gun Simulator','fontsize',18,'fontweight','bold');
%text(xhit*m2i+5,5,sprintf('%4.0f',xhit*m2i));
text(5,gY0-5,{sprintf('Launched at: %4.1f mph',v0*m2i*ips2mph), ...
              sprintf('Hit ground at: %4.0f in',xhit*m2i)} );
hold off;
 
drawnow;
 
return
 
function uifunc
 
%main callback function for ui elements
global gAngle gSpring gStiff gBallMass gCarriageMass gY0 gExitFlag gXtarg gYtarg gAir gEff;
 
itemname = get(gcbo,'Tag');
switch itemname
case 'SpringValue'
   gSpring = str2num(get(gcbo,'String'));
   gSpring = chkrng(gSpring,'SpringSlider');
case 'SpringSlider'
   gSpring = get(gcbo,'Value');
    
case 'AngleValue'
   gAngle = str2num(get(gcbo,'String'));
   gAngle = chkrng(gAngle,'AngleSlider');
case 'AngleSlider'
   gAngle = get(gcbo,'Value');
    
case 'StiffValue'
   gStiff = str2num(get(gcbo,'String'));
   gStiff = chkrng(gStiff,'StiffSlider');
case 'StiffSlider'
   gStiff = get(gcbo,'Value');
    
case 'HeightValue'
   gY0 = str2num(get(gcbo,'String'));
   gY0 = chkrng(gY0,'HeightSlider');
case 'HeightSlider'
   gY0 = get(gcbo,'Value');
    
case 'AirValue'
   gAir = str2num(get(gcbo,'String'));
   gAir = chkrng(gAir,'AirSlider');
case 'AirSlider'
   gAir = get(gcbo,'Value');
    
case 'EffValue'
   gEff = str2num(get(gcbo,'String'));
   gEff = chkrng(gEff,'EffSlider');
case 'EffSlider'
   gEff = get(gcbo,'Value');
    
case 'ExitButton'
   gExitFlag = 1;
otherwise
   fprintf('Unknown callback from %s\n',itemname);
end
UpdatePlot;
return
 
function r = chkrng(val,nam)
h = findobj('Tag',nam);
smax = get(h,'Max');
smin = get(h,'Min');
if (val>smax)
   r=smax;
elseif val<smin
   r=smin;
else
   r=val;
end
 
return
 
function mySlider(name,label,minval,maxval,step1,step2,x,y)
 
b = uicontrol('Parent',gcf, ...
    'Units','normalized', ...
    'Callback','uifunc', ...
    'Max',maxval, ...
    'Min',minval, ...
    'SliderStep',[step1 step2]./(maxval-minval), ...   
    'Position',[x y 0.18 0.03], ...
    'Style','slider', ...
   'Tag',[name 'Slider'], ...
    'Value',minval);
b = uicontrol('Parent',gcf, ...
    'Units','normalized', ...
    'BackgroundColor',[0.831373 0.815686 0.784314], ...
    'Callback','uifunc', ...
    'Position',[x y+.03  0.25 0.03], ...
    'String',label, ...
    'Style','text', ...
    'Tag',[name 'Label']);
b = uicontrol('Parent',gcf, ...
    'Units','normalized', ...
    'BackgroundColor',[1 1 1], ...
    'Callback','uifunc', ...
    'Position',[x+.18 y 0.07 0.03], ...
    'String',num2str(minval), ...
    'Style','edit', ...
    'Tag',[name 'Value']);
 
return
 
 
function initUI
 
%initialize UI elements
global gAngle gSpring gStiff gBallMass gCarriageMass gY0 gExitFlag gXtarg gYtarg gAir gEff;
 
figure(2)
 
set(gcf,'position',[100 100 800 600]);
set(gca,'position',[.1 .4 .8 .5]);
 
% function mySlider(name,label,minval,maxval,step1,step2,x,y)
mySlider('Eff',' Efficiency (%)',           0,    100, 1,   5, .1, .25)
mySlider('Air','Drag Coefficient',             0,   .2, .005,.025, .1, .15)
mySlider('Stiff','Spring Stiffness (lb/in)',   0,    1, .01,   .1, .1, .05)
 
mySlider('Spring','Spring Stretch (in)',       3,   10,  .5,    2, .5, .25)
mySlider('Angle','Angle (degrees)',           15,   45,   1,    5, .5, .15)
mySlider('Height','Launch Height (in)',        0,   60,  .5,    5, .5, .05)
 
b = uicontrol('Parent',gcf, ...
    'Units','normalized', ...
    'Callback','uifunc', ...
    'Position',[0.853571 0.052381 0.1 0.0571429], ...
    'String','Exit', ...
    'Tag','ExitButton');
 
return