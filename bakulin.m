% -------------------------------------------------------------------------
% Gera as velocidades de um modelo de meio acamadado constituído pela
% alternância de 2 camadas, uma isotrópica e outra com fraturamento do tipo
% penny-shaped com background isotrópico. Baseado no trabalho de Schoeberg
% & Douma (1988).
%
% Autor: Marcus Danilo Costa. Data: 28/06/2022
% -------------------------------------------------------------------------

function [Vpz,Vpx,Vsh,Vsv] = bakulin (vel,den,crkd,a,mu,k,nlyr,z1)

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


% Coefs. elást. p/ cam. de cimento+areiafina (background - isotrópico)
C11b = den(1,1)*vel(1,1)^2;
C33b = den(1,1)*vel(1,1)^2;
C44b = den(1,1)*vel(1,2)^2;
C66b = den(1,1)*vel(1,2)^2;
C12b = C11b - 2*C66b;

% DelN e DelT
g = (vel(1,2)/vel(1,1))^2;       % razão g = (Vs/Vp)²
N = 1 + (a*pi*g*(1-g))^(-1)*(k-4*mu/3)/C44b;
T = 1 + 4*(a*pi*(3-2*g))^(-1)*mu/C44b;
DelN =  4*crkd/(3*g*(1 - g)*N)
DelT = 16*crkd/(3*(3 - 2*g)*T)

% Coefs. elást. p/ cam. de cimento+areiafina (com fraturas)
C11c = C11b - (C12b^2/C11b)*DelN;
C33c = C33b*(1 - DelN);
C44c = C44b*(1 - DelT);
C66c = C66b;
C12c = C12b - (C12b^2/C11b)*DelN;
%C13c = C13b*(1 - DelN);

% Coefs. elást. p/ cam. da argamassa (isotrópica)
C11a = den(1,2)*vel(2,1)^2;
C33a = den(1,2)*vel(2,1)^2;
C44a = den(1,2)*vel(2,2)^2;
C66a = den(1,2)*vel(2,2)^2;
C12a = C11a - 2*C66a;


for i = 1:numel(nlyr) % Alterna as amostras
    
    d = z1(1:nlyr(i));
    
    for j = 1:nlyr(i)           % Monta vetor de cada propriedade da amostra
        if mod(j,2) == 1        % camadas ímpares
            C11(j) = C11c;
            C33(j) = C33c;
            C44(j) = C44c;
            C66(j) = C66c;
            C12(j) = C12c;
            rho(j) = den(2,1); 
        else                    % camadas pares
            C11(j) = C11a;
            C33(j) = C33a;
            C44(j) = C44a;
            C66(j) = C66a;
            C12(j) = C12a;
            rho(j) = den(1,2);
        end
    end
    
    % Faz o cálculo de C_ij, Vpz, Vpx, Vsh e Vsv efetivos 

    C33ef = sum(d)/sum(d.*(1./C33));
    C11ef = sum(d.*C11)/sum(d) + C33ef*(sum(d.*(C12./C33))/sum(d))^2 - sum(d.*((C12.^2)./C33))/sum(d);
    C44ef = sum(d)/sum(d.*(1./C44));
    C66ef = sum(d.*C66)/sum(d);
    
    den_ef = sum(d.*rho)/sum(d);
    
    Vpz(i) = sqrt(C33ef/den_ef); 
    Vpx(i) = sqrt(C11ef/den_ef);
    Vsh(i) = sqrt(C66ef/den_ef);
    Vsv(i) = sqrt(C44ef/den_ef);
         
end
 