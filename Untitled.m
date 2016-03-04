clear all;
clc;


sa=90;ma=90;ha=90;
hrx=0;
mrx=0;
srx=0;

hry=1.1;
mry=1.4;
sry=1.9;

sx=[0 srx];
sy=[0 sry];


mx=[0 mrx];
my=[0 mry];


hx=[0 hrx];
hy=[0 hry];



hold on
scatter(0,0,20000);
i=plot(mx,my,'black');
j=plot(sx,sy,'cyan');
k=plot(hx,hy,'yellow');
  delete i;
    delete j;
    delete k;
hold off
while(1)
   
    
    pause(1);
 sx=[0 srx];
sy=[0 sry];


mx=[0 mrx];
my=[0 mry];


hx=[0 hrx];
hy=[0 hry];
   
    sa=sa-6;
    ma=ma-0.1;
    ha=ha-0.0042;
    
    hrx=1.1*sind(ha);
    mrx=1.4*sind(ma);
    srx=1.7*sind(sa);
    
    
    hry=hry-(cosd(ha)*1.1);
    mry=mry-(cosd(ma)*1.4);
    sry=sry-(cosd(sa)*1.7);
  
   hold on
    i=plot(sx,sy,'cyan');
    j=plot(mx,my,'black');
    k=plot(hx,hy,'yellow');
    scatter(0,0,20000,'red');
    delete i;
    delete j;
    delete k;  
    hold off
    
    

end






