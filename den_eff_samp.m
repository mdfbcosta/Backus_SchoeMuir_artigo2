function [den_eff] = den_eff_samp (z1,ncam,rho1,rho2)

% Faz o cálculo da densidade efetiva para cada amostra.
% Retorna um vetor com a densidade de cada amostra: den_eff.

for i = 1:numel(ncam) % numero de modelos
    
    d = z1(1:ncam(i));
    
    for j = 1:ncam(i)  % numero de camadas por modelo
        if mod(j,2) == 1
            rho(j) = rho1;
        else
            rho(j) = rho2;
        end
    end
    
    den_eff(i) = sum(d.*rho)/sum(d);
    
end


end
