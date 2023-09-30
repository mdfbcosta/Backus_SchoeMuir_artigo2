% INFORMAÇOES SOBRE ESTE CÓDIGO -------------------------------------------
% O código chama a function spectrum.m que gera o espectro de frequência da
% forma de onda desejada.
% -------------------------------------------------------------------------

close all
clear all
clc

addpath(genpath('SeisLab_10.0301'))

%% Leitura dos arquivos
freq = 500;

if freq == 500 %% freq.: 500 kHz

    ind = 500;
    
    % Samples
    v1(:,1) = (dlmread('m3_09_dirz_500kHz.txt','',5,0));
    %v1(:,2) = (dlmread('m3_37_dirz_500kHz.txt','',5,0));
    v1(:,2) = (dlmread('m3_73_dirz_500kHz.txt','',5,0));

    % Reference Mortar
    %v1(:,3) = (dlmread('40_D_ARG_AG_500KHz.txt','',5,0));
    %v1(:,3) = (dlmread('40_L_ARG_AG_500KHz.txt','',5,0));
    v1(:,3) = (dlmread('40_J_ARG_AG_500KHz.txt','',5,0));

    % Reference Cement
    v1(:,4) = (dlmread('100_D_CIM_AG_500KHz.txt','',5,0));
    %v1(:,4) = (dlmread('100_L_CIM_AG_500KHz.txt','',5,0));
    %v1(:,4) = (dlmread('100_J_CIM_AG_500KHz.txt','',5,0));
    %                  amostras Jad
    %v1(:,4) = (dlmread('100_JAD_CIM_AF.txt','',5,0));
    %v1(:,4) = (dlmread('100_JAD_CIM_AM.txt','',5,0));
    %v1(:,4) = (dlmread('100_JAD_CIM_AG.txt','',5,0));

    % Transducer
    v1(:,5) = (dlmread('TRANSD500kHz_2.txt','',5,0));

    % Register time
    jt1 = [50 100 100 50 20];  % 500 kHz

elseif freq == 1000  %% freq.: 1 MHz
    
    ind = 1000;
    
    % Samples
    v1(:,1) = (dlmread('m3_09_dirz_1MHz_P_S.txt','',5,0));
    %v1(:,2) = (dlmread('m3_37_dirz_1MHz_P_S.txt','',5,0));
    v1(:,2) = (dlmread('m3_73_dirz_1MHz_P_S.txt','',5,0));

    % Reference Mortar
    %v1(:,3) = (dlmread('40_D_ARG_AG_1MHz.txt','',5,0));
    %v1(:,3) = (dlmread('40_L_ARG_AG_1MHz.txt','',5,0));
    v1(:,3) = (dlmread('40_J_ARG_AG_1MHz.txt','',5,0));

    % Reference Cement
    v1(:,4) = (dlmread('100_D_CIM_AG_1MHz.txt','',5,0));
    %v1(:,4) = (dlmread('100_L_CIM_AG_1MHz.txt','',5,0));
    %v1(:,4) = (dlmread('100_J_CIM_AG_1MHz.txt','',5,0));

    % Transducer
    v1(:,5) = (dlmread('TRANSD1MHzS.txt','',5,0));
    %v1(:,6) = (dlmread('TRANSD1MHzPS_2.txt','',5,0));

    % Register time
    jt1 = [100 100 100 20 20];

end

% Excluindo os 240 primeiros pontos, que são referentes a ruídos
v1 = v1(241:10240,:);
n = size(v1); % Dimensão da matriz v1

% ---

janela = 100;

plot_trace(v1(:,3),janela/n(1,1),[0 20 1050 1600])
hold on
t1 = (linspace(0,janela,n(1,1)))';
plot(t1,v1(:,3),'r','Linewidth',1)
title('Limits of Pass Band Filter [0:350 and 650:1000] kHz')
legend('Pass band filter','Full Waveform')

PBF_T500kHz = load('PBF_T500kHz.txt');
fourierwindow(PBF_T500kHz,janela/n(1,1))
