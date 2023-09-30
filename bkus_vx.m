function [vpx_eff,vsh_eff,vpx_coar,vsh_coar] = bkus_vx (z1,ncam,vp_ref,vs_ref,rho1,rho2,vpz_eff,vsz_eff)

% Entrada:

% Velocidade Vp na direção x:
vp1 = vp_ref(1);
vp2 = vp_ref(2);
vs1 = vs_ref(1);
vs2 = vs_ref(2);

for i = 1:numel(ncam) % numero de modelos
    
    d = z1(1:ncam(i));
    
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
    
    % Cálculo do mod. cisalhamento (mu) e de incompressibilidade (k)
    mu = rho.*vs.^2;
    p = rho.*vp.^2;
    k  = p - 4*mu/3;
    
%% Anterior (usado par ao artigo 1)
%     dmu = d.*mu;
%     mu_ave = sum(dmu)/sum(d); % média ponderada
%     mu_har = sum(d./mu)/sum(d); % média harmônica ponderada
%     dk = d.*k;
%     k_ave = sum(dk)/sum(d);
% 
%     Del_mu = (mu - mu_ave);
%     Del_k = (k - k_ave);
%     %Del_mu = mu(2) - mu(1);
%     %Del_k = k(2) - k(1);
%     
%     varA = (Del_k.*Del_mu + (Del_mu.^2)/3).*d;
%     A = sum(varA)/sum(d);
% 
%     varB = (k + 4*mu/3).*d;
%     B = sum(varB)/sum(d);
% 
%     % Vpx
%     vpx_eff(i)  = vpz_eff(i)*(1 + 2*A/B^2);
%     vpx_coar(i) = sum(d.*vp)/sum(d);  
%     
%     % Vsx   
%     vsh_eff(i)  = vsz_eff(i)*( 1 + ( mu_ave*mu_har -1 )/2 );
%     vsh_coar(i) = sum(d.*vs)/sum(d);
%%

part1 = sum(d.*mu)/sum(d);
part2 = sum(d./p)/sum(d);
part3 = sum(d.*(mu./p))/sum(d);
part4 = sum(d.*(mu.^2./p))/sum(d);
parentE = part1*part2 - part3 + part3^2 - part4*part2;
epsilon = 2*parentE;

part5 = sum(d./mu)/sum(d)
parentG = part1*part5 - 1; 
gamma = parentG/2;

% Vpx
vpx_eff(i)  = vpz_eff(i)*(1 + epsilon);
vpx_coar(i) = sum(d.*vp)/sum(d);  

% Vsx   
vsh_eff(i)  = vsz_eff(i)*(1 + gamma);
vsh_coar(i) = sum(d.*vs)/sum(d);

end


end
