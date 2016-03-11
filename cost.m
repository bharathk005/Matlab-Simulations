clear;
clc;
n_prod=3;
n_dist=3;
n_ret=3;

%prod =[1000 2 3 4 5 6 7 8 9 10]; 
prod = rand(1,n_prod)*5000;
dist = rand(1,n_dist)*2000;
ret = rand(1,n_ret)*2000;

%cpup2d = [1 2 3;4 5 6;7 8 9]; 
% cpup2d --> cost per unit; prod to dist
cpup2d = rand(n_prod,n_dist)*10;
% cpud2r --> cost per unit; dist to retail
cpud2r = rand(n_dist,n_ret)*10;
tcost = 0;
r2dcost = intmax('int32');
d2pcost=intmax('int32');
r2pcost=intmax('int32');
for r= 1:n_ret
   for d = 1:n_dist
       r2dcost =  cpud2r(d,r)*ret(r);
        for p = 1:n_prod
            if(cpup2d(p,d)*dist(d) < d2pcost)
                d2pcost =  cpup2d(p,d)*dist(d);
            end
        end
        if(r2dcost+d2pcost < r2pcost)
            r2pcost = r2dcost+d2pcost;
        end
   end
   tcost = tcost + r2pcost;
   r2dcost = intmax('int32');
    d2pcost=intmax('int32');
    r2pcost=intmax('int32');
end

display(tcost);

