clc
clear all
close all

addpath(genpath('kennet'));

% Leitura dos valores das amostras de referência
load('vel_ref.txt');
load('den_ref.txt');
%load('zi.txt');       % Espessura das camadas
zi = 1.02;
load('ncam.txt');     % Número de camadas

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

for i = 1:length(vec_sam)
    ii = vec_sam(i);
    ly = lyr(1:ii,:);
    [wz,pz,tf] = kennett_aux(ly,wvlt,dt,mopt,fs,disp);

% PZ: sismograma na parte inferior das camadas (deslocamento de partículas)
figure(201)
plot([0:dt:dt*(length(pz)-1)],(pz)),title('transmitted seismogram');
set(gcf,'Position',[50 50 1400 1000]);
[trvl_time(i),y] = ginput(1);
close
    
wvfor_sam(:,i) = pz';
d(i) = sum(ly(:,3));

vel_sam(i) = d(i)/trvl_time(i);

end

%% Salvando arq vels kennet

%save('fvpz_kn_1k.txt','vel_sam','-ascii');  % 100  kHz
%save('fvpz_kn_5k.txt','vel_sam','-ascii');  % 500  kHz
%save('fvpz_kn_1M.txt','vel_sam','-ascii');  % 1000 kHz
