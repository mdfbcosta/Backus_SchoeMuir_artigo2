close all
clear all
clc
%%
addpath(genpath('dados_danilo_artigo2_09_11_22'));

%% Leitura dos arquivos

% Fontes
%src1k = load('.mat');
%src5k = load('.mat');
%src1M = load('.mat');

% Menor nº camadas
a1 = load('49_100k.mat'); % sem fissura
a2 = load('53_500k.mat'); % sem fissura
a3 = load('4_1M_transS.mat'); % sem fissura
b1 = load('16cam_100k_Rec_transS.mat'); % com fissura
b2 = load('16cam_500k_Rec_transS.mat'); % com fissura
b3 = load('16cam_1M_Rec_transS.mat'); % com fissura

% Maior nº de camadas
c1 = load('71_100k.mat');      % sem fissura
c2 = load('53_500k.mat');      % sem fissura
c3 = load('53_1M_transS.mat'); % sem fissura 
d1 = load('72cam_100k.mat');   % com fissura
d2 = load('52cam_500k.mat');   % com fissura
%d3 = load('42cam_1M.mat');     % com fissura
d3 = load('32cam_1M_transS.mat');     % com fissura


%% Coletando apenas a waveform dos arquivos lidos
smth = 80;

% Menor nº de camadas
wfme_sf1k = smooth(a1.src1.Data,smth); wfme_sf1k = double(wfme_sf1k);
wfme_sf5k = smooth(a2.src1.Data,smth); wfme_sf5k = double(wfme_sf5k);
wfme_sf1M = smooth(a3.src1.Data,smth); wfme_sf1M = double(wfme_sf1M);
wfme_cf1k = smooth(b1.src1.Data,smth); wfme_cf1k = double(wfme_cf1k);
wfme_cf5k = smooth(b2.src1.Data,smth); wfme_cf5k = double(wfme_cf5k);
wfme_cf1M = smooth(b3.src1.Data,smth); wfme_cf1M = double(wfme_cf1M);

wfme_cf1k(1:300,1) = wfme_cf1k(300,1)*linspace(0,1,300);
wfme_cf5k = wfme_cf5k - wfme_cf5k(459,1); wfme_cf5k(1:459,1) = wfme_cf5k(459,1)*linspace(0,1,459);
wfme_cf1M(1:300,1) = wfme_cf1M(300,1)*linspace(0,1,300);

save('wfme_cf1k.txt','wfme_cf1k','-ascii');
save('wfme_cf5k.txt','wfme_cf5k','-ascii');
save('wfme_cf1M.txt','wfme_cf1M','-ascii');

% Maior nº de camadas
wfma_sf1k = smooth(c1.src1.Data,smth); wfma_sf1k = double(wfma_sf1k);
wfma_sf5k = smooth(c2.src1.Data,smth); wfma_sf5k = double(wfma_sf5k);
wfma_sf1M = smooth(c3.src1.Data,smth); wfma_sf1M = double(wfma_sf1M);
wfma_cf1k = smooth(d1.src1.Data,smth); wfma_cf1k = double(wfma_cf1k);
wfma_cf5k = smooth(d2.src1.Data,smth); wfma_cf5k = double(wfma_cf5k);
wfma_cf1M = smooth(d3.src1.Data,smth); wfma_cf1M = double(wfma_cf1M);

wfma_cf1k = wfma_cf1k - wfma_cf1k(500,1); wfma_cf1k(1:500,1) = wfma_cf1k(500,1)*linspace(0,1,500);
wfma_cf5k = wfma_cf5k - wfma_cf5k(500,1); wfma_cf5k(1:500,1) = wfma_cf5k(500,1)*linspace(0,1,500);
wfma_cf1M(1:500,1) = wfma_cf1M(500,1)*linspace(0,1,500);

save('wfma_cf1k.txt','wfma_cf1k','-ascii');
save('wfma_cf5k.txt','wfma_cf5k','-ascii');
save('wfma_cf1M.txt','wfma_cf1M','-ascii');

A1ktr = load('Amplfreq1ktr.txt');
A1kme = load('Amplfreq1kme.txt');
A1kma = load('Amplfreq1kma.txt');
A5ktr = load('Amplfreq5ktr.txt');
A5kme = load('Amplfreq5kme.txt');
A5kma = load('Amplfreq5kma.txt');
A1Mtr = load('Amplfreq1Mtr.txt');
A1Mme = load('Amplfreq1Mme.txt');
A1Mma = load('Amplfreq1Mma.txt');

F1ktr = load('specfreq1ktr.txt');
F1kme = load('specfreq1kme.txt');
F1kma = load('specfreq1kma.txt');
F5ktr = load('specfreq5ktr.txt');
F5kme = load('specfreq5kme.txt');
F5kma = load('specfreq5kma.txt');
F1Mtr = load('specfreq1Mtr.txt');
F1Mme = load('specfreq1Mme.txt');
F1Mma = load('specfreq1Mma.txt');


%%
amost = 50; % taxa de amostragem nº/muS.

%% FIGURAS

figure(1)
fsize = 15
line = 2

% 100 kHz
subplot(3,3,1)
hold on
cut = floor(8.5*amost); b = wfme_cf1k;
a1 = b(1:numel(b)-cut);
a2 = zeros(numel(b),1); a2(cut+1:numel(a2),1) = a1;
plot(linspace(0,numel(wfme_cf1k)/amost,numel(wfme_cf1k)),a2,...
    'Color','[0.85 0.325 0.098]','LineWidth',line)
leg1 = legend('16 lyrs')
title('Cracked 100 kHz')
%xlabel('Time (\mu s)')
ylabel('Amplitude (a.u)')
box on; grid on
set(gca,'FontSize',fsize)
xlim([0 70])
clearvars a1 a2 b;

subplot(3,3,4)
hold on
cut = floor(33.33*amost); b = wfma_cf1k;
a1 = b(1:numel(b)-cut);
a2 = zeros(numel(b),1); a2(cut+1:numel(a2),1) = a1;
a2(1:103*amost) = 0.1*a2(1:103*amost);
plot(linspace(0,numel(wfma_cf1k)/amost,numel(wfma_cf1k)),a2,...
    'b','LineWidth',line)
leg1 = legend('72 lyrs')
xlabel('Time (\mu s)')
ylabel('Amplitude (a.u)')
box on; grid on
set(gca,'FontSize',fsize)
xlim([0 250])
clearvars a1 a2 b;

subplot(3,3,7)
hold on
plot((F1ktr/5),abs(A1ktr),'g','LineWidth',line)
plot((F1kme),abs(A1kme),'Color','[0.85 0.325 0.098]','LineWidth',line)
plot((F1kma),abs(A1kma),'b','LineWidth',line)
leg1 = legend('Source','16 lyrs','72 lyrs')
%xlabel('Frequency [log10 kHz]')
xlabel('Frequency [kHz]')
ylabel('Amplitude [a.u]')
box on; grid on
set(gca,'FontSize',fsize)
%set(gca,'XTick',[0 1 2 3])
%xlim([0 3.5])
set(gca,'XTick',[0 100 200 400])
xlim([0 500])

% 500 kHz
subplot(3,3,2)
hold on
cut = floor(9*amost); b = wfme_cf5k; 
a1 = b(1:numel(b)-cut);
a2 = zeros(numel(b),1); a2(cut+1:numel(a2),1) = a1;
plot(linspace(0,numel(wfme_cf5k)/amost,numel(wfme_cf5k)),a2,...
    'Color','[0.85 0.325 0.098]','LineWidth',line)
leg1 = legend('16 lyrs')
title('Cracked 500 kHz')
%xlabel('Time (\mu s)')
box on; grid on
set(gca,'FontSize',fsize)
xlim([0 70])
clearvars a1 a2 b;

subplot(3,3,5)
hold on
cut = floor(25*amost); b = wfma_cf5k; 
a1 = b(1:numel(b)-cut);
a2 = zeros(numel(b),1); a2(cut+1:numel(a2),1) = a1;
a2(1:67*amost) = 0.2*a2(1:67*amost);
plot(linspace(0,numel(wfma_cf5k)/amost,numel(wfma_cf5k)),a2,...
    'b','LineWidth',line)
leg1 = legend('52 lyrs')
xlabel('Time [\mu s]')
box on; grid on
set(gca,'FontSize',fsize)
xlim([0 250])
clearvars a1 a2 b;

subplot(3,3,8)
hold on
plot((F5ktr),abs(A5ktr),'g','LineWidth',line)
plot((F5kme),abs(A5kme),'Color','[0.85 0.325 0.098]','LineWidth',line)
plot((F5kma),abs(A5kma),'b','LineWidth',line)
leg1 = legend('Source','16 lyrs','52 lyrs')
%xlabel('Frequency [log10 kHz]')
xlabel('Frequency [kHz]')
box on; grid on
set(gca,'FontSize',fsize)
%set(gca,'XTick',[0 1 2 3])
%xlim([0 3.5])
xlim([0 800])

% 1 MHz
subplot(3,3,3)
hold on
cut = floor(5*amost); b = wfme_cf1M; 
a1 = b(cut+1:numel(b));
a2 = zeros(numel(b),1); a2(1:numel(a1),1) = a1;
plot(linspace(0,numel(wfme_cf1M)/amost,numel(wfme_cf1M)),a2,...
    'Color','[0.85 0.325 0.098]','LineWidth',line)
leg1 = legend('16 lyrs')
title('Cracked 1 MHz')
%xlabel('Time (\mu s)')
box on; grid on
set(gca,'FontSize',fsize)
xlim([0 70])
clearvars a1 a2 b;

subplot(3,3,6)
hold on
cut = floor(10*amost); b = wfma_cf1M; 
a1 = b(1:numel(b)-cut);
a2 = zeros(numel(b),1); a2(cut+1:numel(a2),1) = a1;
a2(1:40*amost) = 0.1*a2(1:40*amost);
plot(linspace(0,numel(wfma_cf1M)/amost,numel(wfma_cf1M)),a2,...
    'b','LineWidth',line)
leg1 = legend('32 lyrs')
xlabel('Time [\mu s]')
box on; grid on
set(gca,'FontSize',fsize)
xlim([0 250])
clearvars a1 a2 b

subplot(3,3,9)
hold on
plot((F1Mtr),abs(A1Mtr),'g','LineWidth',line)
plot((F1Mme),abs(A1Mme),'Color','[0.85 0.325 0.098]','LineWidth',line)
plot((F1Mma),abs(A1Mma),'b','LineWidth',line)
leg1 = legend('Source','16 lyrs','32 lyrs')
%xlabel('Frequency [log10 kHz]')
xlabel('Frequency [kHz]')
box on; grid on
set(gca,'FontSize',fsize)
%set(gca,'XTick',[0 1 2 3])
%xlim([0 3.5])
set(gca,'XTick',[0 200 500 1000 1500])
xlim([0 1500])


set(gcf,'Position',[50 50 1500 1000])