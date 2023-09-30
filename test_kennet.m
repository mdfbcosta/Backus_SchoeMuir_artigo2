clc
clear all
close all

addpath(genpath('kennet'));

% Leitura dos valores das amostras de referência
load('vel_ref.txt');
load('den_ref.txt');
load('zi.txt');       % Espessura das camadas
load('ncam.txt');     % Número de camadas
load('ncam_d.txt');     

%% Construção dos arquivos de cada transdutor

tij1k = [vel_ref(1,1) den_ref(1) zi/1000; vel_ref(2,1) den_ref(2) zi/1000];
tij5k = [vel_ref(1,3) den_ref(1) zi/1000; vel_ref(2,3) den_ref(2) zi/1000];
tij1M = [vel_ref(1,5) den_ref(1) zi/1000; vel_ref(2,5) den_ref(2) zi/1000];

for i = 1:2:ncam(numel(ncam))
   arq1k(i:i+1,:) = tij1k;
   arq5k(i:i+1,:) = tij5k;
   arq1M(i:i+1,:) = tij1M;
end

%% Escolha do arquivo que será executado

lyr = arq1M;
vec_sam = ncam;  % vetor amostras

wvlt = sourcewvlt;
%dt = 1.9531*1e-9;  %janela de 20uS
%dt = 4.8828*1e-8;  %janela de 50uS
dt = 9.7656*1e-8;  %janela de 100uS

%% Parâmetros da forma de onda total que setão usados

mopt = 5;     % = 0 para reflexões primárias apenas
              % = 1 para múltiplas de 1ª ordem
              % qualquer valor calcula todas as reverberações
                          
fs = 0;       % = 0 para nenhuma múltipla de superfície livre
              % = 1 para múltiplas de superfície livre
              
disp = -1;     % = n (n < núm. de camadas) (parâmetro opcional)
              % opção de exibição para mostrar a refletividade e transmissividade
              % conforme ela está sendo calculada recursivamente da parte inferior
              % da pilha de camadas para o topo. Não mostrado quando DISP não é especificado
              % = -1 impede a exibição de qualquer sismograma.

%%

% % for i = 1:length(vec_sam)
% %     ii = vec_sam(i);
% %     ly = lyr(1:ii,:);
% %     [wz,pz,tf] = kennett_aux(ly,wvlt,dt,mopt,fs,disp);
% % 
% % % PZ: sismograma na parte inferior das camadas (deslocamento de partículas)
% % figure(201)
% % plot([0:dt:dt*(length(pz)-1)],(pz)),title('transmitted seismogram');
% % set(gcf,'Position',[50 50 1400 1000]);
% % [trvl_time(i),y] = ginput(1);
% % close
% %     
% % wvfor_sam(:,i) = pz';
% % d(i) = sum(ly(:,3));
% % 
% % vel_sam(i) = d(i)/trvl_time(i);
% % 
% % end

%% Salvando arq vels kennet

%save('vpz_kn_1k.txt','vel_sam','-ascii');  % 100  kHz
%save('vpz_kn_5k.txt','vel_sam','-ascii');  % 500  kHz
%save('vpz_kn_1M.txt','vel_sam','-ascii');  % 1000 kHz


%% ========================================================================
%                             BACKUS SEM FISSURA
%% ======================================================================== 

load('vpz_bk_100.txt')
load('vpz_bk_500.txt');
load('vpz_bk_1000.txt');


%% ========================================================================
%                             BAKULIN -- FISSURA
%% ======================================================================== 

load('vpz_bl_100.txt')
load('vpz_bl_500.txt')
load('vpz_bl_1000.txt')


%% ========================================================================
%                   VALORES EXPERIMENTAIS -- COM FISSURA
%% ======================================================================== 

load('vpz_1k_cf.txt');
load('vpz_5k_cf.txt');
load('vpz_1M_cf.txt');

%% ========================================================================
%                   VALORES EXPERIMENTAIS -- SEM FISSURA
%% ======================================================================== 

load('vpz_1k_sf.txt');
load('vpz_5k_sf.txt');
load('vpz_1M_sf.txt');

%% ========================================================================
%                                 KENNETT
%% ======================================================================== 

% Normal
vpz_kn_1k = load('vpz_kn_1k.txt');
vpz_kn_5k = load('vpz_kn_5k.txt');
vpz_kn_1M = load('vpz_kn_1M.txt');

% Simulando fissuras
fvpz_kn_1k = load('fvpz_kn_1k.txt');
fvpz_kn_5k = load('fvpz_kn_5k.txt');
fvpz_kn_1M = load('fvpz_kn_1M.txt');


%% ========================================================================
%                         APROXIMAÇÃO DO RAIO
%% ======================================================================== 

vp_ray1k = load('vp_ray1k.txt');
vp_ray5k = load('vp_ray5k.txt');
vp_ray1M = load('vp_ray1M.txt');


%========================
%% FIGURAS
%========================



figure(1)
fsize = 15;

subplot(1,3,1)
hold on
plot(vpz_1k_sf,ncam,'or','MarkerFaceColor',[1 0 0])
plot(vpz_1k_cf,ncam,'ob','MarkerFaceColor',[0 0 1])
plot(vpz_kn_1k,ncam,'*-k')
%plot(fvpz_kn_1k,ncam,'*-c')
plot(vpz_bk_100,ncam,'--r')
plot(vpz_bl_100,ncam,'--b')
plot(vp_ray1k,ncam,'r')
ylabel('Number of layers')
xlabel('Velocity [m/s]')
%set(gca,'YTick',ncam(1:10))
set(gca,'FontSize',fsize)
set(gca,'YDir','reverse')
title('V_{PZ} 100 kHz')
xlim([1000 3000])
grid on; box on

subplot(1,3,2)
hold on
plot(vpz_5k_sf,ncam(1:numel(vpz_5k_sf)),'or','MarkerFaceColor',[1 0 0])
plot(vpz_5k_cf,ncam(1:numel(vpz_5k_cf)),'ob','MarkerFaceColor',[0 0 1])
plot(vpz_kn_5k,ncam,'*-k')
%plot(fvpz_kn_5k,ncam,'*-c')
plot(vpz_bk_500,ncam,'--r')
plot(vpz_bl_500,ncam,'--b')
plot(vp_ray5k,ncam,'r')
xlabel('Velocity [m/s]')
%set(gca,'YTick',ncam(1:10))
set(gca,'FontSize',fsize)
set(gca,'YDir','reverse')
title('V_{PZ} 500 kHz')
xlim([1000 3500])
grid on; box on

subplot(1,3,3)
hold on
plot(vpz_1M_sf(1:numel(vpz_1M_sf)-4),ncam(1:numel(vpz_1M_sf)-4),'or','MarkerFaceColor',[1 0 0])
plot(vpz_1M_cf(1:numel(vpz_1M_cf)-3),ncam(1:numel(vpz_1M_cf)-3),'ob','MarkerFaceColor',[0 0 1])
plot(vpz_kn_1M,ncam,'*-k')
%plot(fvpz_kn_1M,ncam,'*-c')
plot(vpz_bk_1000,ncam,'--r')
plot(vpz_bl_1000,ncam,'--b')
plot(vp_ray1M,ncam,'r')
xlabel('Velocity [m/s]')
%set(gca,'YTick',ncam(1:10))
set(gca,'FontSize',fsize)
set(gca,'YDir','reverse')
title('V_{PZ} 1 MHz')
legend('Uncracked','Cracked','Kennett','Backus Uncracked','Backus Cracked','Ray T. Uncraked')
set(legend,...
    'Position',[0.281521193513546 0.141114537707953 0.42879018979361 0.0900102696880412],...
    'NumColumns',3);
xlim([1000 3500])
grid on; box on

set(gcf,'Position',[50 50 1500 1000]);