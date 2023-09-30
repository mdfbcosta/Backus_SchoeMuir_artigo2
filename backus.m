% -------------------------------------------------------------------------
% Gera as velocidades de um modelo de meio acamadado constituído pela
% alternância de 2 camadas, uma isotrópica e outra com fraturamento do tipo
% penny-shaped com background isotrópico. Baseado no trabalho de Schoeberg
% & Douma (1988).
%
% Autor: Marcus Danilo Costa. Data: 28/06/2022
% -------------------------------------------------------------------------

function [Vpz,Vpx,Vsh,Vsv,Vp_ray] = backus (vel,den,nlyr,z1)

%--------------------------------------------------------------------------
% Dados de entrada
% vel (matr 2x2) --> Col 1: Vp; Col 2: Vs; Nas linhas: parâm. das camadas
% den            --> Vetor densidade das camadas
% crkd           --> densidade de fissura da camada fissurada

% Dados de saída
% Vpz, Vpx --> Velocidade compressional no eixo-Z e -X
% Vsh, Vsv --> Velocidade de cisalhamento no eixo-X, pol. h e v
% -------------------------------------------------------------------------


% Coef. elást. C1: cimento+areiafina (isotrópico)
C11c = den(1)*vel(1,1)^2;
C33c = den(1)*vel(1,1)^2;
C44c = den(1)*vel(1,2)^2;
C66c = den(1)*vel(1,2)^2;
C12c = C11c - 2*C66c;

% Coef. elást. C2: argamassa (isotrópica)
C11a = den(2)*vel(2,1)^2;
C33a = den(2)*vel(2,1)^2;
C44a = den(2)*vel(2,2)^2;
C66a = den(2)*vel(2,2)^2;
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
            rho(j) = den(1);
            
            vp(j) = vel(1,1);
            vs(j) = vel(1,2);
        else                    % camadas pares
            C11(j) = C11a;
            C33(j) = C33a;
            C44(j) = C44a;
            C66(j) = C66a;
            C12(j) = C12a;
            rho(j) = den(2);
            
            vp(j) = vel(2,1);
            vs(j) = vel(2,2);
        end
    end
    
    % Faz o cálculo dos C_ij e de Vpz, Vpx, Vsh e Vsv efetivos 

    C33ef = sum(d)/sum(d.*(1./C33));
    C11ef = sum(d.*C11)/sum(d) + C33ef*(sum(d.*(C12./C33))/sum(d))^2 - sum(d.*((C12.^2)./C33))/sum(d);
    C44ef = sum(d)/sum(d.*(1./C44));
    C66ef = sum(d.*C66)/sum(d);
    
    den_ef = sum(d.*rho)/sum(d);
    
    Vpz(i) = sqrt(C33ef/den_ef); 
    Vpx(i) = sqrt(C11ef/den_ef);
    Vsh(i) = sqrt(C66ef/den_ef);
    Vsv(i) = sqrt(C44ef/den_ef);
    
    Vp_ray(i) = sum(d)/sum(d./vp);
         
end
 