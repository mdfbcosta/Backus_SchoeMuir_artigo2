%__________________________________________________________________________
%
% Este programa faz o calculo teórico das velocidades da onda elástica
% viajando dentro de um meio acamadado usando o formalismo da média de
% Backus para o meio apenas com camadas, e o formalismo apresentado em
% bakulin para o caso de fissuras dentro das camadas.
%__________________________________________________________________________

clc
clear all
close all


% % % Velocidades amostra de referência: 100 kHz (1k)
% % vp_c_1k = 1.3*2328.06;   % cim+areia fina [m/s]
% % vs_c_1k = 0.6*vp_c_1k;   % cim+areia fina [m/s]
% % vp_a_1k = 1.3*1570.38;   % acrílico [m/s]
% % vs_a_1k = 0.6*vp_a_1k;   % acrílico [m/s]
% % % Velocidades amostra de referência: 500 kHz (5k)
% % vp_c_5k = 3587.51;   % cim+areia fina [m/s]
% % vs_c_5k = 2365.55;   % cim+areia fina [m/s]
% % vp_a_5k = 2564.67;   % acrílico [m/s]
% % vs_a_5k = 1296.37;   % acrílico [m/s]
% % % Velocidades amostra de referência: 1 MHz (1M)
% % vp_c_1M = 3931.22;   % cim+areia fina [m/s] (medida da ref do lado)
% % vs_c_1M = 2436.05;   % cim+areia fina [m/s] (medida da ref do lado)
% % %vp_c_1M = 3733.69;   % cim+areia fina [m/s] 
% % %vs_c_1M = 2257.04;   % cim+areia fina [m/s]
% % vp_a_1M = 2651.79;   % acrílico [m/s]
% % vs_a_1M = 1289.66;   % acrílico [m/s]


% Amostra de referência: 100 kHz (1k)
vp_c_1k = 2910.10    % 1.25*2328.06;  VP kHz (cim+areia-fina) [m/s]
vs_c_1k = 1746.00    % 0.6*vp_c_1k;   VS kHz (cim+areia-fina) [m/s]
vp_a_1k = 2041.50;   % VP 100 kHz (acrílico) [m/s]
vs_a_1k = 1224.90;   % VS 100 kHz (acrílico) [m/s]

% Amostra de referência: 500 kHz (5k)
vp_c_5k = 3191.81;   % VP 500 kHz (cim+areia-fina) [m/s]
vs_c_5k = 1878.14;   % VS 500 kHz (cim+areia-fina) [m/s]
vp_a_5k = 2564.67;   % VP 500 kHz (acrílico) [m/s]
vs_a_5k = 1296.37;   % VS 500 kHz (acrílico) [m/s]

% Amostra de referência: 1 MHz (1M)
vp_c_1M = 3497.61;   % VP 1 MHz (cim+areia-fina) [m/s] (medida da ref do lado)
vs_c_1M = 1934.11;   % VS 1 MHz (cim+areia-fina) [m/s] (medida da ref do lado)
%vp_c_1M = 3297.61;  % cim+areia fina [m/s] (medida da ref do lado)
%vs_c_1M = 1894.11;  % cim+areia fina [m/s] (medida da ref do lado)
vp_a_1M = 2651.79;   % VP 1 MHz (acrílico) [m/s]
vs_a_1M = 1289.66;   % VS 1 MHz (acrílico) [m/s]

% Densidades amostra de referência
%ro_c = 2150;         % cim+areia fina [kg/m3] (medida da ref do lado)
ro_c = 1880;         % cim+areia fina [kg/m3] (medido da ref de uma das camadas)
ro_a = 1180;         % acrílico [kg/m3] 

% Organizando dados de entrada em matriz (para Bakulin)
vel_1k = [vp_c_1k vs_c_1k; vp_a_1k vs_a_1k];
vel_5k = [vp_c_5k vs_c_5k; vp_a_5k vs_a_5k];
vel_1M = [vp_c_1M vs_c_1M; vp_a_1M vs_a_1M];
den = [ro_c ro_a];  % para entrada do Backus normal (sem fissuras)

vel_ref = [vel_1k vel_5k vel_1M];
save('vel_ref.txt','vel_ref','-ascii');
save('den_ref.txt','den','-ascii');

% % Orgagnizando dados de entrada em matriz (para Backus)
% vp_1k = [vp_c_1k vp_a_1k];     % Ordem: [Vp da C1  Vp C2]
% vs_1k = [vs_c_1k vs_a_1k];     % Ordem: [Vs da C1  Vs C2]
% vp_5k = [vp_c_5k vp_a_5k];     % Ordem: [Vp da C1  Vp C2]
% vs_5k = [vs_c_5k vs_a_5k];     % Ordem: [Vs da C1  Vs C2]
% vp_1M = [vp_c_1M vp_a_1M];     % Ordem: [Vp da C1  Vp C2]
% vs_1M = [vs_c_1M vs_a_1M];     % Ordem: [Vs da C1  Vs C2]


% Quantidade de amostras
ncam = [5:8:180];
save('ncam.txt','ncam','-ascii');

% Espessura médias das camadas que compõem cada amostra
zi = 2.0482;  % [mm]
save('zi.txt','zi','-ascii');
aleat = rand(1,ncam(numel(ncam)))-rand(1,ncam(numel(ncam)));
erro = 0.0; %0.0117;
z1 = ( zi + erro*aleat )/1000; % [m] Simula irregularidades aleatórias


%% FORMALISMO DE BACKUS

% CHAMANDO FUNÇÃO DE BACKUS

% % Vpz e Vsz (= Vsv)
% [vpz_bk_1k, vsz_bk_1k, vpz_co_1k, vsz_co_1k] = bkus_vz (z1,ncam,vp_1k,vs_1k,ro_c,ro_a);
% [vpz_bk_5k, vsz_bk_5k, vpz_co_5k, vsz_co_5k] = bkus_vz (z1,ncam,vp_5k,vs_5k,ro_c,ro_a);
% [vpz_bk_1M, vsz_bk_1M, vpz_co_1M, vsz_co_1M] = bkus_vz (z1,ncam,vp_1M,vs_1M,ro_c,ro_a);
% 
% % Vpx e Vsh
% [vpx_bk_1k, vsh_bk_1k, vpx_co_1k, vsh_co_1k] = bkus_vx (z1,ncam,vp_1k,vs_1k,ro_c,ro_a,vpz_bk_1k,vsz_bk_1k);
% [vpx_bk_5k, vsh_bk_5k, vpx_co_5k, vsh_co_5k] = bkus_vx (z1,ncam,vp_5k,vs_5k,ro_c,ro_a,vpz_bk_5k,vsz_bk_5k);
% [vpx_bk_1M, vsh_bk_1M, vpx_co_1M, vsh_co_1M] = bkus_vx (z1,ncam,vp_1M,vs_1M,ro_c,ro_a,vpz_bk_1M,vsz_bk_1M);

% Para 100 kHz
[vpz_bk_1k, vpx_bk_1k, vsh_bk_1k, vsz_bk_1k,vp_ray1k] = backus (vel_1k,den,ncam,z1);
% Para 500 kHz
[vpz_bk_5k, vpx_bk_5k, vsh_bk_5k, vsz_bk_5k,vp_ray5k] = backus (vel_5k,den,ncam,z1);
% Para 1 MHz
[vpz_bk_1M, vpx_bk_1M, vsh_bk_1M, vsz_bk_1M,vp_ray1M] = backus (vel_1M,den,ncam,z1);

save('vpz_bk_100.txt','vpz_bk_1k','-ascii')
save('vpx_bk_100.txt','vpx_bk_1k','-ascii')
save('vsz_bk_100.txt','vsz_bk_1k','-ascii')
save('vsh_bk_100.txt','vsh_bk_1k','-ascii')

save('vpz_bk_500.txt','vpz_bk_5k','-ascii')
save('vpx_bk_500.txt','vpx_bk_5k','-ascii')
save('vsz_bk_500.txt','vsz_bk_5k','-ascii')
save('vsh_bk_500.txt','vsh_bk_5k','-ascii')

save('vpz_bk_1000.txt','vpz_bk_1M','-ascii')
save('vpx_bk_1000.txt','vpx_bk_1M','-ascii')
save('vsz_bk_1000.txt','vsz_bk_1M','-ascii')
save('vsh_bk_1000.txt','vsh_bk_1M','-ascii')

save('vp_ray1k.txt','vp_ray1k','-ascii')
save('vp_ray5k.txt','vp_ray5k','-ascii')
save('vp_ray1M.txt','vp_ray1M','-ascii')


%% FORMALISMO DE BAKULIN

% DEFININDO ALGUNS PARAMETROS DO FORMALISMO

pi = 3.14159265359;                % Valor de PI
nfis = 9;                          % nº fiss. do vol. abaixo do trans.
c = 0.00127;                       % [m] crack aperture
%c = 0.00068;                       % [m] altura da fissura
a = 0.00567;                       % [m] diâmetro da fissura
r = a/2;                           % [m] raio da fissura  
vfis = (pi*r^2)*c;                 % [m³] Vol. da fissura (todas iguais)
vtot = (pi*0.02^2)*zi/1000;        % [m³] Para transdutor de 500 kHz
                                   % inclusões em cada camada.
alp = c/a;                         % Razão de aspecto.                                   
crkd = (nfis/vtot)*vfis;           % Density cracked 500 kHz
k_iso  = 2e+8;                     % Bulk modulus do Isopor
mu_iso = 1.3e+8;                   % Shear modulus do Isopor

vtotP = zi*80.09*80.87/1000000000;       % das camadas
ro_c_fis = ro_c*(1 - nfis*vfis/vtotP);   % Densidade aparente com fissuras
den_bl = [ro_c ro_a;ro_c_fis ro_a];      % entrada do Bakulin (fissuras)

% CHAMANDO A FUNÇÃO DE BAKULIN

%[vpz_bl_1k,vpx_bl_1k,vsh_bl_1k,vsv_bl_1k] = bakulin2 (vel_1k,den_bl,crkd,alp,mu_iso,k_iso,ncam,z1);
%[vpz_bl_5k,vpx_bl_5k,vsh_bl_5k,vsv_bl_5k] = bakulin2 (vel_5k,den_bl,crkd,alp,mu_iso,k_iso,ncam,z1);
%[vpz_bl_1M,vpx_bl_1M,vsh_bl_1M,vsv_bl_1M] = bakulin2 (vel_1M,den_bl,crkd,alp,mu_iso,k_iso,ncam,z1);
[vpz_bl_1k,vpx_bl_1k,vsh_bl_1k,vsv_bl_1k] = bakulin (vel_1k,den_bl,crkd,alp,mu_iso,k_iso,ncam,z1);
[vpz_bl_5k,vpx_bl_5k,vsh_bl_5k,vsv_bl_5k] = bakulin (vel_5k,den_bl,crkd,alp,mu_iso,k_iso,ncam,z1);
[vpz_bl_1M,vpx_bl_1M,vsh_bl_1M,vsv_bl_1M] = bakulin (vel_1M,den_bl,crkd,alp,mu_iso,k_iso,ncam,z1);


save('rho_ef.txt','vpz_bl_1k','-ascii')

save('vpz_bl_100.txt','vpz_bl_1k','-ascii')
save('vpx_bl_100.txt','vpx_bl_1k','-ascii')
save('vsh_bl_100.txt','vsh_bl_1k','-ascii')
save('vsv_bl_100.txt','vsv_bl_1k','-ascii')

save('vpz_bl_500.txt','vpz_bl_5k','-ascii')
save('vpx_bl_500.txt','vpx_bl_5k','-ascii')
save('vsh_bl_500.txt','vsh_bl_5k','-ascii')
save('vsv_bl_500.txt','vsv_bl_5k','-ascii')

save('vpz_bl_1000.txt','vpz_bl_1M','-ascii')
save('vpx_bl_1000.txt','vpx_bl_1M','-ascii')
save('vsh_bl_1000.txt','vsh_bl_1M','-ascii')
save('vsv_bl_1000.txt','vsv_bl_1M','-ascii')


%% Parâmetros de Thomsen
%                                  thoms_param2
[e_sf,g_sf,d_sf,e_cf,g_cf,d_cf] = thoms_param (vel_1k,den_bl,crkd,alp,mu_iso,k_iso,ncam,z1);
save('e_sf_1k.txt','e_sf','-ascii')
save('g_sf_1k.txt','g_sf','-ascii')
save('d_sf_1k.txt','d_sf','-ascii')
save('e_cf_1k.txt','e_cf','-ascii')
save('g_cf_1k.txt','g_cf','-ascii')
save('d_cf_1k.txt','d_cf','-ascii')
%                                  thoms_param2
[e_sf,g_sf,d_sf,e_cf,g_cf,d_cf] = thoms_param (vel_5k,den_bl,crkd,alp,mu_iso,k_iso,ncam,z1);
save('e_sf_5k.txt','e_sf','-ascii')
save('g_sf_5k.txt','g_sf','-ascii')
save('d_sf_5k.txt','d_sf','-ascii')
save('e_cf_5k.txt','e_cf','-ascii')
save('g_cf_5k.txt','g_cf','-ascii')
save('d_cf_5k.txt','d_cf','-ascii')
%                                  thoms_param2
[e_sf,g_sf,d_sf,e_cf,g_cf,d_cf] = thoms_param (vel_1M,den_bl,crkd,alp,mu_iso,k_iso,ncam,z1);
save('e_sf_1M.txt','e_sf','-ascii')
save('g_sf_1M.txt','g_sf','-ascii')
save('d_sf_1M.txt','d_sf','-ascii')
save('e_cf_1M.txt','e_cf','-ascii')
save('g_cf_1M.txt','g_cf','-ascii')
save('d_cf_1M.txt','d_cf','-ascii')


%% Densidade efetiva

% do background (sem fissuras)
[ro_ef_sf] = den_eff_samp (z1,ncam,ro_c,ro_a);
save('ro_ef_sf.txt','ro_ef_sf','-ascii')

% do background (sem fissuras)
[ro_ef_cf] = den_eff_samp (z1,ncam,ro_c_fis,ro_a);
save('ro_ef_cf.txt','ro_ef_cf','-ascii')

save('ncam_teorico.txt','ncam','-ascii')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% GERANDO FIGURAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 100 kHz

figure(1)

subplot(1,4,1)
hold on
plot(vpz_bk_1k,ncam,'r','LineWidth',2)
plot(vpz_bl_1k,ncam,'ok','LineWidth',2)
title('V_{PZ}')
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
legend('Sem fissura','Com fissura')
title(legend,'100 kHz')
grid on
box on

subplot(1,4,2)
hold on
plot(vpx_bk_1k,ncam,'r','LineWidth',2)
plot(vpx_bl_1k,ncam,'ok','LineWidth',2)
title('V_{PX}')
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
legend('Sem fissura','Com fissura')
title(legend,'100 kHz')
grid on
box on

subplot(1,4,3)
hold on
plot(vsh_bk_1k,ncam,'r','LineWidth',2)
plot(vsh_bl_1k,ncam,'ok','LineWidth',2)
title('V_{SH}')
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
legend('Sem fissura','Com fissura')
title(legend,'100 kHz')
grid on
box on

subplot(1,4,4)
hold on
plot(vsz_bk_1k,ncam,'r','LineWidth',2)
plot(vsv_bl_1k,ncam,'ok','LineWidth',2)
title('V_{SZ}')
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
legend('Sem fissura','Com fissura')
title(legend,'100 kHz')
grid on
box on

set(gcf,'Position',[50 50 1500 1000])

% 500 kHz

figure(2)

subplot(1,4,1)
hold on
plot(vpz_bk_5k,ncam,'r','LineWidth',2)
plot(vpz_bl_5k,ncam,'ok','LineWidth',2)
title('V_{PZ}')
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
legend('Sem fissura','Com fissura')
title(legend,'500 kHz')
grid on
box on

subplot(1,4,2)
hold on
plot(vpx_bk_5k,ncam,'r','LineWidth',2)
plot(vpx_bl_5k,ncam,'ok','LineWidth',2)
title('V_{PX}')
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
legend('Sem fissura','Com fissura')
title(legend,'500 kHz')
grid on
box on

subplot(1,4,3)
hold on
plot(vsh_bk_5k,ncam,'r','LineWidth',2)
plot(vsh_bl_5k,ncam,'ok','LineWidth',2)
title('V_{SH}')
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
legend('Sem fissura','Com fissura')
title(legend,'500 kHz')
grid on
box on

subplot(1,4,4)
hold on
plot(vsz_bk_5k,ncam,'r','LineWidth',2)
plot(vsv_bl_5k,ncam,'ok','LineWidth',2)
title('V_{SZ}')
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
legend('Sem fissura','Com fissura')
title(legend,'500 kHz')
grid on
box on

set(gcf,'Position',[50 50 1500 1000])

% 1 Mega

figure(3)

subplot(1,4,1)
hold on
plot(vpz_bk_1M,ncam,'r','LineWidth',2)
plot(vpz_bl_1M,ncam,'ok','LineWidth',2)
title('V_{PZ}')
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
legend('Sem fissura','Com fissura')
title(legend,'1 MHz')
grid on
box on

subplot(1,4,2)
hold on
plot(vpx_bk_1M,ncam,'r','LineWidth',2)
plot(vpx_bl_1M,ncam,'ok','LineWidth',2)
title('V_{PX}')
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
legend('Sem fissura','Com fissura')
title(legend,'1 MHz')
grid on
box on

subplot(1,4,3)
hold on
plot(vsh_bk_1M,ncam,'r','LineWidth',2)
plot(vsh_bl_1M,ncam,'ok','LineWidth',2)
title('V_{SH}')
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
legend('Sem fissura','Com fissura')
title(legend,'1 MHz')
grid on
box on

subplot(1,4,4)
hold on
plot(vsz_bk_1M,ncam,'r','LineWidth',2)
plot(vsv_bl_1M,ncam,'ok','LineWidth',2)
title('V_{SZ}')
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
legend('Sem fissura','Com fissura')
title(legend,'1 MHz')
grid on
box on

set(gcf,'Position',[50 50 1500 1000])

figure(4)
hold on
plot(ro_ef_sf,ncam,'or','LineWidth',2)
plot(ro_ef_cf,ncam,'ok','LineWidth',2)
title('\rho')
ylabel('Number of Layers')
xlabel('Density [m/s]')
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
legend('Sem fissura','Com fissura')
grid on; box on

set(gcf,'Position',[50 50 500 1000])