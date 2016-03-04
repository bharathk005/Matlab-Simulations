a1=zeros(3,3);
a2=a1;
a3=a2;a4=a2;a5=a3;a6=a2;a7=a2;a8=a2;a9=a2;
c1=[a1;a2;a3];
c2=[a4;a5;a6];
c3=[a7;a8;a9];
s=[c1 c2 c3];

nk=input('number of knowns?');
p=zeros(nk);
display('enter the positions');
for i=1:nk
   p(i)=input(' ');
   if p(i)>81 ||p(i)<1
       display('wrong input');
       test_su;
   end
end
display('enter the knowns');
for i=1:nk
    s(p(i))=input(' ');
end

display(s);


    
    


