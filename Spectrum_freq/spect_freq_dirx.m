close all
clear all
clc

% SOBRE ESTE CÓDIGO -------------------------------------------------------
% Gera o espectro de frequencias das formas de ondas desejadas
% -------------------------------------------------------------------------

addpath(genpath('SeisLab_10.0301'));
addpath(genpath('500kHz_26-05-20'));
addpath(genpath('1MHz_S_P'));

dado = ler_dados ();

freq = [500 1000]; % As duas frequencias que temos

for j = 1:2 % Duas frequencias: 500 kHz e 1MHz

    if freq(j) == 500  % freq.: 500 kHz

        ind = 500;    
        ii_final = size(dado.t500_010818);
        for ii = 1:ii_final(1)
            v1(:,ii) = dado.t500_010818{ii,1};
        end

        % Janela de amostragem
        jt1 = [10 10 10 10 10 5 10 10 10 10 10 10 10 10 10 10]*10;  % micro-segundos

        name = {'Samp 05','Samp 09','Samp 13','Samp 17','Samp 21','Samp 25',...
                'Samp 29','Samp 33','Samp 37','Samp 41','Samp 45','Samp 49',...
                'Samp 53','Samp 57','Samp 61','Samp 73'};
        color = {'r','g','y','k','b','c','m','w','r','g','y','k','b','c','m','w'};
        shape = {'o','o','o','o','o','o','o','o','square','square','square','square','square','square','square','square'};
    
    elseif freq(j) == 1000  % freq.: 1 MHz
    
        clearvars v1;
        ind = 1000;
        ii_final = size(dado.t1MHz_wps);
        for ii = 1:ii_final(1)
            v1(:,ii) = dado.t1MHz_wps{ii,1};
        end

        % Janela de amostragem
        jt1 = [10 10 10 10 10 10 10 10 10 10 10 10 5]*10;

        name = {'Samp 09','Samp 13','Samp 17','Samp 21','Samp 25','Samp 29',...
                'Samp 33','Samp 37','Samp 41','Samp 45','Samp 49','Samp 53',...
                'Samp 73'};
        color = {'g','y','k','b','c','m','w','r','g','y','k','b','w'};
        shape = {'o','o','o','o','o','o','o','square','square','square','square','square','square'};

    end

    % Zerando os 240 primeiros pontos, que são referentes a ruídos
    %v1(1:240,:) = 0.0;
    n = size(v1); % Dimensão da matriz v1
    
    if freq(j) == 500
        limits_filter = [0 30 1000 1600]; %Para 500 kHz      
    elseif freq(j) == 1000
        limits_filter = [0 30 1500 1600]; %Para 1 MHz
    end
    
    for i = 1:n(1,2)
        trace = plot_trace(v1(:,i),jt1(i)/n(1,1),limits_filter);    
        [f(:,i),A(:,i),f_max(i),A_max(i)] = freq_dominant(trace,jt1(i)/n(1,1))
    end
    
%     if ind == 500
%         save('freqMax500x.txt','f_max','-ascii');
%         save('AmplMax500x.txt','A_max','-ascii');
%         save('specfreq500x.txt','f','-ascii');
%         save('Amplfreq500x.txt','A','-ascii');        
%     elseif ind == 1000
%         save('freqMax1000x.txt','f_max','-ascii');
%         save('AmplMax1000x.txt','A_max','-ascii');
%         save('specfreq1000x.txt','f','-ascii');
%         save('Amplfreq1000x.txt','A','-ascii');        
%     end
    
    clearvars v1
    clearvars f_max
    clearvars A_max 
    
end
