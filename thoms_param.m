% -------------------------------------------------------------------------
% Parametros de Thomsen teóricos
%
% Autor: Marcus Danilo Costa. Data: 17/01/2023
% -------------------------------------------------------------------------

function [e_sf,g_sf,d_sf,e_cf,g_cf,d_cf] = thoms_param (vel,den,crkd,a,mu,k,nlyr,z1)

%--------------------------------------------------------------------------
% Dados de entrada
% vel (matr 2x2) --> Col 1: Vp; Col 2: Vs; Nas linhas: parâm. das camadas
% den            --> Vetor densidade das camadas
% crkd           --> densidade de fissura da camada fissurada
% a              --> Razao de aspecto da fissura
% mu             --> Shear modulus do preenchimento da fissura (isopor)
% k              --> Bulk modulus do preenchimento da fissura (isopor)

% Dados de saída
% Vpz, Vpx --> Velocidade compressional no eixo-Z e -X
% Vsh, Vsv --> Velocidade de cisalhamento no eixo-X, pol. h e v
% -------------------------------------------------------------------------

% Coefs. elást. p/ cam. da argamassa (isotrópica)
C11a = den(1,2)*vel(2,1)^2;
C33a = den(1,2)*vel(2,1)^2;
C44a = den(1,2)*vel(2,2)^2;
C66a = den(1,2)*vel(2,2)^2;
C12a = C11a - 2*C66a;
C13a = C12a;

% Coefs. elást. p/ cam. de cimento+areiafina
C11c = den(1,1)*vel(1,1)^2;
C33c = den(1,1)*vel(1,1)^2;
C44c = den(1,1)*vel(1,2)^2;
C66c = den(1,1)*vel(1,2)^2;
C12c = C11c - 2*C66c;
C13c = C12c;

for i = 1:numel(nlyr) % Alterna as amostras
    
    d = z1(1:nlyr(i));
    
    for j = 1:nlyr(i)           % Monta vetor de cada propriedade da amostra
        if mod(j,2) == 1        % camadas ímpares
            C11(j) = C11c;
            C33(j) = C33c;
            C44(j) = C44c;
            C66(j) = C66c;
            C12(j) = C12c;
            C13(j) = C13c;
            rho(j) = den(1,1);
            rho2(j) = den(2,1);
        else                    % camadas pares
            C11(j) = C11a;
            C33(j) = C33a;
            C44(j) = C44a;
            C66(j) = C66a;
            C12(j) = C12a;
            C13(j) = C13a;
            rho(j) = den(1,2);
            rho2(j) = den(1,2);            
        end
    end
    
    % Faz o cálculo de C_ij, Vpz, Vpx, Vsh e Vsv efetivos 

    C33ef = sum(d)/sum(d.*(1./C33));
    C11ef = sum(d.*C11)/sum(d) + C33ef*(sum(d.*(C12./C33))/sum(d))^2 - sum(d.*((C12.^2)./C33))/sum(d);
    C44ef = sum(d)/sum(d.*(1./C44));
    C66ef = sum(d.*C66)/sum(d);
    C12ef = C11ef - 2*C66ef
    C13ef = C33ef*(sum(d.*(C12./C33))/sum(d));

    e_sf(i) = (C11ef - C33ef)/2/C33ef; 
    g_sf(i) = (C66ef - C44ef)/2/C44ef;
    d_sf(i) = ( (C13ef+C44ef)^2 - (C33ef-C44ef)^2 )/( 2*C33ef*(C33ef-C44ef) );
    
end



% Coefs. elást. p/ cam. de cimento+areiafina (background - isotrópico)
C11b = den(1,1)*vel(1,1)^2;
C33b = den(1,1)*vel(1,1)^2;
C44b = den(1,1)*vel(1,2)^2;
C66b = den(1,1)*vel(1,2)^2;
C12b = C11b - 2*C66b;
C13b = C12b;

% DelN e DelT
g = (vel(1,2)/vel(1,1))^2;       % razão g = (Vs/Vp)²
N = 1 + (a*pi*g*(1-g))^(-1)*(k-4*mu/3)/C44b;
T = 1 + 4*(a*pi*(3-2*g))^(-1)*mu/C44b;
DelN =  4*crkd/(3*g*(1 - g)*N)
DelT = 16*crkd/(3*(3 - 2*g)*T)

clearvars C11c C33c C44c C66c C12c C13c
clearvars C11 C33 C44 C66 C12 C13 rho rho2

% Coefs. elást. p/ cam. de cimento+areiafina (com fraturas)
C11c = C11b - (C12b^2/C11b)*DelN;
C33c = C33b*(1 - DelN);
C44c = C44b*(1 - DelT);
C66c = C66b;
C12c = C12b - (C12b^2/C11b)*DelN;
C13c = C13b*(1 - DelN);


for i = 1:numel(nlyr) % Alterna as amostras
    
    d = z1(1:nlyr(i));
    
    for j = 1:nlyr(i)           % Monta vetor de cada propriedade da amostra
        if mod(j,2) == 1        % camadas ímpares
            C11(j) = C11c;
            C33(j) = C33c;
            C44(j) = C44c;
            C66(j) = C66c;
            C12(j) = C12c;
            C13(j) = C13c;
            rho(j) = den(1,1);
            rho2(j) = den(2,1);
        else                    % camadas pares
            C11(j) = C11a;
            C33(j) = C33a;
            C44(j) = C44a;
            C66(j) = C66a;
            C12(j) = C12a;
            C13(j) = C13a;
            rho(j) = den(1,2);
            rho2(j) = den(1,2);            
        end
    end
    
    % Faz o cálculo de C_ij, Vpz, Vpx, Vsh e Vsv efetivos 

    C33ef = sum(d)/sum(d.*(1./C33));
    C11ef = sum(d.*C11)/sum(d) + C33ef*(sum(d.*(C12./C33))/sum(d))^2 - sum(d.*((C12.^2)./C33))/sum(d);
    C44ef = sum(d)/sum(d.*(1./C44));
    C66ef = sum(d.*C66)/sum(d);
    C12ef = C11ef - 2*C66ef
    C13ef = C33ef*(sum(d.*(C12./C33))/sum(d));
    
    e_cf(i) = (C11ef - C33ef)./2/C33ef; 
    g_cf(i) = (C66ef - C44ef)./2/C44ef;
    d_cf(i) = ( (C13ef+C44ef).^2 - (C33ef-C44ef).^2 )./( 2*C33ef.*(C33ef-C44ef) );


end