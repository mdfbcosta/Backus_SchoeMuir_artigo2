function [vp_thin,vs_thin,vp_coar,vs_coar] = bkus_vz (z1,ncam,vp_ref,vs_ref,rho1,rho2)

% Gera as velocidades de onda P na direção Z usando a teoria de backus.
% Autor: Marcus Danilo Costa. Data: 13/03/2019

% Entrada:
% zi --> espessura das camadas
% vp1 e vp2 --> valores das velocidades de onda P de cada camada
% ncam --> vetor, cuja quantidade de elementos indica o número de modelos e
% cada elemento expressa a quantidade de camadas de cada modelo.

% Saída:
% vp_thin --> velocidades de backus
% vp_coar --> velocidades para meio de camadas grossas

vp1 = vp_ref(1);
vp2 = vp_ref(2);
vs1 = vs_ref(1);
vs2 = vs_ref(2);

for i = 1:numel(ncam) % numero de modelos
 
     z = z1(1:ncam(i));
    
    for j = 1:ncam(i)  % numero de camadas por modelo
        if mod(j,2) == 1
            rho(j) = rho1;
            vp(j) = vp1;
            vs(j) = vs1;            
        else
            rho(j) = rho2;
            vp(j) = vp2;
            vs(j) = vs2; 
        end
    end
    
    %Vpz
    g = ( sum( rho.*z )/sum(z) )*sum( z.*(rho.*vp.^2).^(-1) );
    vp_thin(i) = sqrt( sum(z)/g );
    vp_coar(i) = 1/( (1./sum(z)) * sum(z./vp) );
    
    %Vsz
    g = ( sum( rho.*z )/sum(z) )*sum( z.*(rho.*vs.^2).^(-1) );
    vs_thin(i) = sqrt( sum(z)/g );
    vs_coar(i) = 1/( (1./sum(z)) * sum(z./vs) );
    
end

end 