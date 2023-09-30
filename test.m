
vp1 = 3200;
vp2 = 2650;
vs1 = 2200;
vs2 = 1650; 
r1 = 1.8;
r2 = 1.6;
d = 0.1;
D = linspace(1,50,10);
phi1 = 0.1;
phi2 = 0.3;


f = d./D;
vp =[vp1 vp2 vp1 vp2 vp1 vp2 vp1 vp2 vp1 vp2];
vs =[vs1 vs2 vs1 vs2 vs1 vs2 vs1 vs2 vs1 vs2];
den = [r1 r2 r1 r2 r1 r2 r1 r2 r1 r2];
phi = [phi1 phi2 phi1 phi2 phi1 phi2 phi1 phi2 phi1 phi2]

%for i = 1:10
 
    [c(:,:), rho, por] = bkuslog (D, vp, vs, den, phi);
    
%end 

vpz = sqrt( c(3,3)./rho );

plot(vpz,D)



