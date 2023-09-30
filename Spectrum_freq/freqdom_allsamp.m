close all
clear all
clc

% SOBRE ESTE CÓDIGO -------------------------------------------------------
% Coleta a frequencia dominante de cada forma de onda
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
            v1(:,ii) = dado.t500_010818{ii,3};
        end

        % Janela de amostragem
        jt1 = [2 5 10 10 10 5 10 10 10 10 10 10 10 10 10 10]*10;  % micro-segundos

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
            v1(:,ii) = dado.t1MHz_wps{ii,3};
        end

        % Janela de amostragem
        jt1 = [10 10 10 10 10 10 10 10 10 10 10 10 10]*10;

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
        [f,A,f_max(i),A_max(i)] = freq_dominant(trace,jt1(i)/n(1,1))
    end
    
    if ind == 500
        save('freqMax500z.txt','f_max','-ascii');
        save('AmplMax500z.txt','A_max','-ascii');
    elseif ind == 1000
        save('freqMax1000z.txt','f_max','-ascii');
        save('AmplMax1000z.txt','A_max','-ascii');
    end
    
    clearvars v1
    clearvars f_max
    clearvars A_max 
    
end






%
%     
% %% Estudo da frequencia dominante
% 
% j = 0;
% for i = 1:n(1,2)
%     j = j + 1;
%     
%     jt = jt1(i);
%     t1 = (linspace(0,jt,n(1,1)))';
%     dt = (jt/length(t1))/1.e+6;  % em segundos
%     
%     v1_suav = v1(:,i);
% %     v1_filter = band_pass(v1_suav,dt,[0 20 500 600])
% %     plot(t1,v1_suav)
% %     axis tight
% %     grid on
% %     [limX,y] = ginput(2)
% %     clearvars y
% %     close
% %     for d = 1:2
% %         x(d) = find(abs(t1 - limX(d)) == min(abs(t1 - limX(d))))
% %     end
% %     plot(t1(x(1):x(2)),v1_suav(x(1):x(2)))
% %     spectrum_fourier_subplot(v1_suav(x(1):x(2)),dt,j,i,name);
%    
%    spectrum_fourier_subplot(v1_suav,dt,j,i,name,ind);
% end
% 
% 
% %% Generation Velocity
% 
% % j = 0;
% % for i = 4:n(1,2)-1
% %     j = j + 1;
% %     
% %     jt = jt1(i);
% %     t = (linspace(0,jt,n(1,1)))';
% %     at_P(j,1:2) = pick_time(movmean(v1(:,i),100),t,i,name);
% %     if ind == 1000
% %         fileID = fopen('temp_p_s_refs_1MHz.txt','w');
% %     elseif ind == 500
% %         fileID = fopen('temp_p_s_refs_500kHz.txt','w');
% %     end
% %     fprintf(fileID,'%12.8f %12.8f\n',at_P');
% %     fclose(fileID);
% %     
% % end
% 
% if ind == 1000
%     at_P = load('temp_p_s_refs_1MHz.txt');
% elseif ind == 500
%     at_P = load('temp_p_s_refs_500kHz.txt');
% end
% 
% dimZ = [49.69 40.1]; % Order: argamassa | cimento
% 
% v_P = 1000*(dimZ./at_P(:,1)');  % in [m/s]
% v_S = 1000*(dimZ./at_P(:,2)');  % in [m/s]
% if ind == 1000
%     fileID1 = fopen('vp_mc_ref_1MHz.txt','w');
%     fileID2 = fopen('vs_mc_ref_1MHz.txt','w');    
% elseif ind == 500
%     fileID1 = fopen('vp_mc_ref_500kHz.txt','w');
%     fileID2 = fopen('vs_mc_ref_500kHz.txt','w');    
% end
% fprintf(fileID1,'%12.8f %12.8f\n',v_P');
% fprintf(fileID2,'%12.8f %12.8f\n',v_S');
% fclose(fileID1);
% fclose(fileID2);
% 
% 
% %% FIGURE
% 
% figure(10)
% hold on
% plot([1 2],v_P,'-ok','LineWidth',3);
% plot([1 2],v_S,'-or','LineWidth',3);
% legend('v_P','v_S')
% xticks([1 2])
% xticklabels({'Mor','Cem'})
% grid on
% box off
% set(gca,'Fontsize',16);
% xlabel('Reference plugs')
% ylabel('Velocity [m/s]')
% if ind == 500
%     title('Reference velocity - 500 kHz')
% elseif ind == 1000
%     title('Reference velocity - 1000 MHz')
% end