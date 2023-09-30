close all
clear all
clc

% -------------------------------------------------------------------
% Este código gera o espectro de frequencias das formas de onda
% -------------------------------------------------------------------

addpath(genpath('Spectrum_freq'));
addpath(genpath('dados_danilo_artigo2_09_11_22'));
addpath(genpath('SeisLab_10.0301'));
%%
a = load('fontePeS_1MHz.mat'); fonte1M = double(a.src1.Data);
%%

freq = [100 500 1000]; % As duas frequencias que temos

for j = 3 % 1:numel(freq)  % Roda as três frequencias

    if freq(j) == 100
    
        ind = 100;
        v1 = dlmread('TRANSD500kHz_2.txt','',5,0);  % Sinal transdutor
        v2 = load('wfme_cf1k.txt'); % Menor nº camadas 1k
        v3 = load('wfma_cf1k.txt'); % Maior nº camadas 1k
        % Janela de amostragem
        jt1 = [ 20 100 500 ];  % micro-segundos

    elseif freq(j) == 500

        ind = 500;
        v1 = dlmread('TRANSD500kHz_2.txt','',5,0); % Sinal transdutor
        v2 = load('wfme_cf5k.txt'); % Menor nº camadas 5k   
        v3 = load('wfma_cf5k.txt'); % Maior nº camadas 5k
        % Janela de amostragem
        jt1 = [ 20 500 500 ];  % micro-segundos


    elseif freq(j) == 1000
    
        ind = 1000;
        %v1 = dlmread('TRANSD1MHzS.txt','',5,0); % Sinal transdutor
        v1 = fonte1M'; % Sinal transdutor        
        v2 = load('wfme_cf1M.txt'); % Menor nº camadas 1M
        v3 = load('wfma_cf1M.txt'); % Maior nº camadas 1M
        % Janela de amostragem
        jt1 = [ 20 100 500 ];  % micro-segundos
    
    end

    % Zerando os 240 primeiros pontos referentes aos ruídos
    %v1(1:240,:) = 0.0;

    name = {'Source transducer','Ref.: mort40+coar-sand60',...
            'Ref.: cement100', 'Sample of 09 layers', 'Sample of 73 layers'};
 
    if freq(j) == 100
        limits_filter = [0 30 1000 1600]; %Para 100 kHz
    elseif freq(j) == 500
        limits_filter = [0 30 1000 1600]; %Para 500 kHz
    elseif freq(j) == 1000
        limits_filter = [0 30 1950 2000]; %Para 1 MHz      
    end
    
    trace = plot_trace(v1,jt1(1)/numel(v1),limits_filter);
    [f1,A1] = fourierwindow(trace,jt1(1)/numel(v1),name,ind)

    trace = plot_trace(v2,jt1(2)/numel(v2),limits_filter);
    [f2,A2] = fourierwindow(trace,jt1(2)/numel(v2),name,ind)

    trace = plot_trace(v3,jt1(3)/numel(v3),limits_filter);
    [f3,A3] = fourierwindow(trace,jt1(3)/numel(v3),name,ind)

    if ind == 100
        save('specfreq1ktr.txt','f1','-ascii');
        save('specfreq1kme.txt','f2','-ascii');
        save('specfreq1kma.txt','f3','-ascii');
        save('Amplfreq1ktr.txt','A1','-ascii');
        save('Amplfreq1kme.txt','A2','-ascii');
        save('Amplfreq1kma.txt','A3','-ascii');        
    elseif ind == 500
        save('specfreq5ktr.txt','f1','-ascii');
        save('specfreq5kme.txt','f2','-ascii');
        save('specfreq5kma.txt','f3','-ascii');
        save('Amplfreq5ktr.txt','A1','-ascii');
        save('Amplfreq5kme.txt','A2','-ascii');
        save('Amplfreq5kma.txt','A3','-ascii');        
    elseif ind == 1000
        save('specfreq1Mtr.txt','f1','-ascii');
        save('specfreq1Mme.txt','f2','-ascii');
        save('specfreq1Mma.txt','f3','-ascii');
        save('Amplfreq1Mtr.txt','A1','-ascii');
        save('Amplfreq1Mme.txt','A2','-ascii');
        save('Amplfreq1Mma.txt','A3','-ascii');
    end
    
    clearvars v1 v2 v3
    clearvars f1 f2 f3
    clearvars A1 A2 A3
    
end
