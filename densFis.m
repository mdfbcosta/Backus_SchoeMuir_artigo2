ncam = [5:4:180];

c = 0.00127;                       % [m] altura da fissura
a = 0.00567;                       % [m] diâmetro da fissura
r = a/2;                           % [m] raio da fissura  
vfis = (pi*r^2)*c;   

nfis1 = 9

nfis2 = ncam*nfis1; 
vtot  = (0.040*0.040*0.002045)*ncam;

denF = nfis2*vfis./vtot;

plot(ncam,denF)

