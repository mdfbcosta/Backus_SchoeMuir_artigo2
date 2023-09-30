function [m3] = ler_dados ()

% O objetivo da função é ler os arquivos que serão analisados
% Saída: Uma struct, chamada "m3", com os arquivos lidos
%
% Detalhes:
%   A struct m3 armazenará várias matrizes. Os elementos de cada matriz
%   também serão matrizes, para isso usamos o recurso "cell array"
%   As colunas das matrizes de m3 representam Direções e Polarizações
%   As linhas representam o aumento do número de camadas
%   Cada elemento dessa matriz representa uma aquisição ultrassônica 

%

%% Adicione o Diretório de onde serão lidos os arquivos

addpath(genpath('wafer_dir_x_z (01-08-2018)'))        % 1ª aquisição vert e horiz realizada. Transdutor 1MHz e 500KHz
addpath(genpath('wafer_dir_x no topo (10-10-2018)'))  % Aquisição realizada no topo de cada amostra
addpath(genpath('wafer_08-03-19'))                    % Nova aquisição vert e horiz
addpath(genpath('wafer_73-layersample_14-05-2019'))   % Aquisição horizontal na amostra 73 ao longo de Z
addpath(genpath('wafer_21-05-19'))                    % Ultima aquisição vert e horiz 500KHz 

% Transdutor 1MHz de ondas P e S em (01-08-2018)
%                     Direção x e polarização S1                  Direção x e polariação S2                  Direção z
m3.t1MHz_wps = {dlmread('m3_09_dirx_1MHz_P_S1.txt','',5,0), dlmread('m3_09_dirx_1MHz_P_S2.txt','',5,0), dlmread('m3_09_dirz_1MHz_P_S.txt','',5,0);
              dlmread('m3_13_dirx_1MHz_P_S1.txt','',5,0), dlmread('m3_13_dirx_1MHz_P_S2.txt','',5,0), dlmread('m3_13_dirz_1MHz_P_S.txt','',5,0);
              dlmread('m3_17_dirx_1MHz_P_S1.txt','',5,0), dlmread('m3_17_dirx_1MHz_P_S2.txt','',5,0), dlmread('m3_17_dirz_1MHz_P_S.txt','',5,0);
              dlmread('m3_21_dirx_1MHz_P_S1.txt','',5,0), dlmread('m3_21_dirx_1MHz_P_S2.txt','',5,0), dlmread('m3_21_dirz_1MHz_P_S.txt','',5,0);
              dlmread('m3_25_dirx_1MHz_P_S1.txt','',5,0), dlmread('m3_25_dirx_1MHz_P_S2.txt','',5,0), dlmread('m3_25_dirz_1MHz_P_S.txt','',5,0);
              dlmread('m3_29_dirx_1MHz_P_S1.txt','',5,0), dlmread('m3_29_dirx_1MHz_P_S2.txt','',5,0), dlmread('m3_29_dirz_1MHz_P_S.txt','',5,0);
              dlmread('m3_33_dirx_1MHz_P_S1.txt','',5,0), dlmread('m3_33_dirx_1MHz_P_S2.txt','',5,0), dlmread('m3_33_dirz_1MHz_P_S.txt','',5,0);
              dlmread('m3_37_dirx_1MHz_P_S1.txt','',5,0), dlmread('m3_37_dirx_1MHz_P_S2.txt','',5,0), dlmread('m3_37_dirz_1MHz_P_S.txt','',5,0);
              dlmread('m3_41_dirx_1MHz_P_S1.txt','',5,0), dlmread('m3_41_dirx_1MHz_P_S2.txt','',5,0), dlmread('m3_41_dirz_1MHz_P_S.txt','',5,0);
              dlmread('m3_45_dirx_1MHz_P_S1.txt','',5,0), dlmread('m3_45_dirx_1MHz_P_S2.txt','',5,0), dlmread('m3_45_dirz_1MHz_P_S.txt','',5,0);
              dlmread('m3_49_dirx_1MHz_P_S1.txt','',5,0), dlmread('m3_49_dirx_1MHz_P_S2.txt','',5,0), dlmread('m3_49_dirz_1MHz_P_S.txt','',5,0);
              dlmread('m3_53_dirx_1MHz_P_S1.txt','',5,0), dlmread('m3_53_dirx_1MHz_P_S2.txt','',5,0), dlmread('m3_53_dirz_1MHz_P_S.txt','',5,0);
              dlmread('m3_73_dirx_1MHz_P_S1.txt','',5,0), dlmread('m3_73_dirx_1MHz_P_S2.txt','',5,0), dlmread('m3_73_dirz_1MHz_P_S.txt','',5,0)};
          
% Transdutor 1MHz de onda P (01-08-2018)
%                            Direção X                                 Direção Z
m3.t1MHz_wp = {dlmread('m3_09_dirx_1MHz_P.txt','',5,0), dlmread('m3_09_dirz_1MHz_P.txt','',5,0);
             dlmread('m3_13_dirx_1MHz_P.txt','',5,0), dlmread('m3_13_dirz_1MHz_P.txt','',5,0);
             dlmread('m3_17_dirx_1MHz_P.txt','',5,0), dlmread('m3_17_dirz_1MHz_P.txt','',5,0);
             dlmread('m3_21_dirx_1MHz_P.txt','',5,0), dlmread('m3_21_dirz_1MHz_P.txt','',5,0);
             dlmread('m3_25_dirx_1MHz_P.txt','',5,0), dlmread('m3_25_dirz_1MHz_P.txt','',5,0);
             dlmread('m3_29_dirx_1MHz_P.txt','',5,0), dlmread('m3_29_dirz_1MHz_P.txt','',5,0);
             dlmread('m3_33_dirx_1MHz_P.txt','',5,0), dlmread('m3_33_dirz_1MHz_P.txt','',5,0);
             dlmread('m3_37_dirx_1MHz_P.txt','',5,0), dlmread('m3_37_dirz_1MHz_P.txt','',5,0);
             dlmread('m3_41_dirx_1MHz_P.txt','',5,0), dlmread('m3_41_dirz_1MHz_P.txt','',5,0);
             dlmread('m3_45_dirx_1MHz_P.txt','',5,0), dlmread('m3_45_dirz_1MHz_P.txt','',5,0);
             dlmread('m3_49_dirx_1MHz_P.txt','',5,0), dlmread('m3_49_dirz_1MHz_P.txt','',5,0);
             dlmread('m3_53_dirx_1MHz_P.txt','',5,0), dlmread('m3_53_dirz_1MHz_P.txt','',5,0);
             dlmread('m3_73_dirx_1MHz_P.txt','',5,0), dlmread('m3_73_dirz_1MHz_P.txt','',5,0)};
   
%% Transdutor 500KHz (01-08-2018); Pasta: 500kHz_mix_final. Composição final após análise 27-05-2020
%
%                  Direção x e polarização S1            Direção x e polariação S2             Direção z
m3.t500_010818 = {dlmread('m3_05_x_500_S1.txt','',5,0), dlmread('m3_05_x_500_S2.txt','',5,0), dlmread('m3_05_z_500.txt','',5,0);
                  dlmread('m3_09_x_500_S1.txt','',5,0), dlmread('m3_09_x_500_S2.txt','',5,0), dlmread('m3_09_z_500.txt','',5,0);
                  dlmread('m3_13_x_500_S1.txt','',5,0), dlmread('m3_13_x_500_S2.txt','',5,0), dlmread('m3_13_z_500.txt','',5,0);
                  dlmread('m3_17_x_500_S1.txt','',5,0), dlmread('m3_17_x_500_S2.txt','',5,0), dlmread('m3_17_z_500.txt','',5,0);
                  dlmread('m3_21_x_500_S1.txt','',5,0), dlmread('m3_21_x_500_S2.txt','',5,0), dlmread('m3_21_z_500.txt','',5,0);
                  dlmread('m3_25_x_500_S1.txt','',5,0), dlmread('m3_25_x_500_S2.txt','',5,0), dlmread('m3_25_z_500.txt','',5,0);
                  dlmread('m3_29_x_500_S1.txt','',5,0), dlmread('m3_29_x_500_S2.txt','',5,0), dlmread('m3_29_z_500.txt','',5,0);
                  dlmread('m3_33_x_500_S1.txt','',5,0), dlmread('m3_33_x_500_S2.txt','',5,0), dlmread('m3_33_z_500.txt','',5,0);
                  dlmread('m3_37_x_500_S1.txt','',5,0), dlmread('m3_37_x_500_S2.txt','',5,0), dlmread('m3_37_z_500.txt','',5,0);
                  dlmread('m3_41_x_500_S1.txt','',5,0), dlmread('m3_41_x_500_S2.txt','',5,0), dlmread('m3_41_z_500.txt','',5,0);
                  dlmread('m3_45_x_500_S1.txt','',5,0), dlmread('m3_45_x_500_S2.txt','',5,0), dlmread('m3_45_z_500.txt','',5,0);
                  dlmread('m3_49_x_500_S1.txt','',5,0), dlmread('m3_49_x_500_S2.txt','',5,0), dlmread('m3_49_z_500.txt','',5,0);
                  dlmread('m3_53_x_500_S1.txt','',5,0), dlmread('m3_53_x_500_S2.txt','',5,0), dlmread('m3_53_z_500.txt','',5,0);
                  dlmread('m3_57_x_500_S1.txt','',5,0), dlmread('m3_57_x_500_S2.txt','',5,0), dlmread('m3_57_z_500.txt','',5,0);
                  dlmread('m3_61_x_500_S1.txt','',5,0), dlmread('m3_61_x_500_S2.txt','',5,0), dlmread('m3_61_z_500.txt','',5,0);                
                  dlmread('m3_73_x_500_S1.txt','',5,0), dlmread('m3_73_x_500_S2.txt','',5,0), dlmread('m3_73_z_500.txt','',5,0)};

            
%% Transdutor 500KHz (10-10-2018)
% Foi feita uma única medida na Direção-X de cada amostra, localizando os transdutores no topo das amostras (Fig.1).
% Nesta configuração todas as medidas estão submetidas à mesma pressão.
%   _  ____  _
%--[_] ---- [_]--
%      ----
%      ----
%      ----
%      ----
%      ____
%    Figura 1
%                                    Polarização S1                              Polarização S2
m3.t500_top_x = {dlmread('top_05_dirx_500KHz_P_S1.txt','',5,0), dlmread('top_05_dirx_500KHz_P_S2.txt','',5,0);
                 dlmread('top_09_dirx_500KHz_P_S1.txt','',5,0), dlmread('top_09_dirx_500KHz_P_S2.txt','',5,0);    
                 dlmread('top_13_dirx_500KHz_P_S1.txt','',5,0), dlmread('top_13_dirx_500KHz_P_S2.txt','',5,0);
                 dlmread('top_17_dirx_500KHz_P_S1.txt','',5,0), dlmread('top_17_dirx_500KHz_P_S2.txt','',5,0);
                 dlmread('top_21_dirx_500KHz_P_S1.txt','',5,0), dlmread('top_21_dirx_500KHz_P_S2.txt','',5,0);
                 dlmread('top_25_dirx_500KHz_P_S1.txt','',5,0), dlmread('top_25_dirx_500KHz_P_S2.txt','',5,0);
                 dlmread('top_29_dirx_500KHz_P_S1.txt','',5,0), dlmread('top_29_dirx_500KHz_P_S2.txt','',5,0);
                 dlmread('top_33_dirx_500KHz_P_S1.txt','',5,0), dlmread('top_33_dirx_500KHz_P_S2.txt','',5,0);
                 dlmread('top_37_dirx_500KHz_P_S1.txt','',5,0), dlmread('top_37_dirx_500KHz_P_S2.txt','',5,0);
                 dlmread('top_41_dirx_500KHz_P_S1.txt','',5,0), dlmread('top_41_dirx_500KHz_P_S2.txt','',5,0);
                 dlmread('top_45_dirx_500KHz_P_S1.txt','',5,0), dlmread('top_45_dirx_500KHz_P_S2.txt','',5,0);
                 dlmread('top_49_dirx_500KHz_P_S1.txt','',5,0), dlmread('top_49_dirx_500KHz_P_S2.txt','',5,0);
                 dlmread('top_53_dirx_500KHz_P_S1.txt','',5,0), dlmread('top_53_dirx_500KHz_P_S2.txt','',5,0);
                 dlmread('top_57_dirx_500KHz_P_S1.txt','',5,0), dlmread('top_57_dirx_500KHz_P_S2.txt','',5,0);      
                 dlmread('top_73_dirx_500KHz_P_S1.txt','',5,0), dlmread('top_73_dirx_500KHz_P_S2.txt','',5,0)};

% % Transdutor 500MHz (08-03-19). Apenas direção Z
% %                              Direção-Z.
% m3.t500kHz_wps_dirZ={dlmread('wafer09_dirz_500khz.txt','',5,0);
%                       dlmread('wafer17_dirz_500khz.txt','',5,0);
%                       dlmread('wafer21_dirz_500khz.txt','',5,0);
%                       dlmread('wafer25_dirz_500khz.txt','',5,0);
%                       dlmread('wafer29_dirz_500khz.txt','',5,0);
%                       dlmread('wafer33_dirz_500khz.txt','',5,0);
%                       dlmread('wafer37_dirz_500khz.txt','',5,0);
%                       dlmread('wafer41_dirz_500khz.txt','',5,0);
%                       dlmread('wafer45_dirz_500khz.txt','',5,0);
%                       dlmread('wafer49_dirz_500khz.txt','',5,0);
%                       dlmread('wafer53_dirz_500khz.txt','',5,0);
%                       dlmread('wafer61_dirz_500khz.txt','',5,0);
%                       dlmread('wafer73_dirz_500khz_v.txt','',5,0)};
%           
% % Transdutor 500KHz (21-05-2019). Direção Z, X-S1, X-S2, Y-S1 e Y-S2
% %                         Dir-x e Pol-S1                    Dir-x e Pol-S2                  Dir-y e Pol-S1                   Dir-y e Pol-S2                     Direção z
% m3.t500kHz_210519 = {dlmread('s9_dx_s1.txt','',5,0) , dlmread('s9_dx_s2.txt','',5,0) , dlmread('s9_dy_s1.txt','',5,0) , dlmread('s9_dy_s2.txt','',5,0) , dlmread('s9_dz.txt','',5,0) ;
%                   dlmread('s17_dx_s1.txt','',5,0), dlmread('s17_dx_s2.txt','',5,0), dlmread('s17_dy_s1.txt','',5,0), dlmread('s17_dy_s2.txt','',5,0), dlmread('s17_dz.txt','',5,0);
%                   dlmread('s21_dx_s1.txt','',5,0), dlmread('s21_dx_s2.txt','',5,0), dlmread('s21_dy_s1.txt','',5,0), dlmread('s21_dy_s2.txt','',5,0), dlmread('s21_dz.txt','',5,0);
%                   dlmread('s29_dx_s1.txt','',5,0), dlmread('s29_dx_s2.txt','',5,0), dlmread('s29_dy_s1.txt','',5,0), dlmread('s29_dy_s2.txt','',5,0), dlmread('s29_dz.txt','',5,0);
%                   dlmread('s39_dx_s1.txt','',5,0), dlmread('s39_dx_s2.txt','',5,0), dlmread('s39_dy_s1.txt','',5,0), dlmread('s39_dy_s2.txt','',5,0), dlmread('s39_dz_a.txt','',5,0);
%                   dlmread('s45_dx_s1.txt','',5,0), dlmread('s45_dx_s2.txt','',5,0), dlmread('s45_dy_s1.txt','',5,0), dlmread('s45_dy_s2.txt','',5,0), dlmread('s45_dz.txt','',5,0);
%                   dlmread('s49_dx_s1.txt','',5,0), dlmread('s49_dx_s2.txt','',5,0), dlmread('s49_dy_s1.txt','',5,0), dlmread('s49_dy_s2.txt','',5,0), dlmread('s49_dz.txt','',5,0);
%                   dlmread('s53_dx_s1.txt','',5,0), dlmread('s53_dx_s2.txt','',5,0), dlmread('s53_dy_s1.txt','',5,0), dlmread('s53_dy_s2.txt','',5,0), dlmread('s53_dz_a.txt','',5,0);
%                   dlmread('s57_dx_s1.txt','',5,0), dlmread('s57_dx_s2.txt','',5,0), dlmread('s57_dy_s1.txt','',5,0), dlmread('s57_dy_s2.txt','',5,0), 0;
%                   dlmread('s61_dx_s1.txt','',5,0), dlmread('s61_dx_s2.txt','',5,0), dlmread('s61_dy_s1.txt','',5,0), dlmread('s61_dy_s2.txt','',5,0), dlmread('s61_dz.txt','',5,0);
%                   dlmread('s73_dx_s1.txt','',5,0), dlmread('s73_dx_s2.txt','',5,0), dlmread('s73_dy_s1.txt','',5,0), dlmread('s73_dy_s2.txt','',5,0), dlmread('s73_dz_a.txt','',5,0)};
% 
% % Transdutor 500MHz (14-05-19) - Amostra 73-camadas. Medidas na Dir-X variando em Z
% %   _  ____  _              ____                 ____
% %--[_] ---- [_]--  |     _  ----  _     |        ----
% %      ----        |  --[_] ---- [_]--  |     _  ----  _
% %      ----        |        ----        |  --[_] ---- [_]--
% %      ----        |        ----        |        ----
% %      ----        |        ----        |        ----
% %      ____        |        ____        |        ____
% %                         
% %                         Figura 1
% %
% %                                Direção-X, variando o Z.
% m3.t500_73_x = {dlmread('S1_med_001.txt','',5,0), dlmread('S2_med_001.txt','',5,0);
%                 dlmread('S1_med_002.txt','',5,0), dlmread('S2_med_002.txt','',5,0);
%                 dlmread('S1_med_003.txt','',5,0), dlmread('S2_med_003.txt','',5,0);
%                 dlmread('S1_med_004.txt','',5,0), dlmread('S2_med_004.txt','',5,0);
%                 dlmread('S1_med_005.txt','',5,0), dlmread('S2_med_005.txt','',5,0);
%                 dlmread('S1_med_006.txt','',5,0), dlmread('S2_med_006.txt','',5,0);
%                 dlmread('S1_med_007.txt','',5,0), dlmread('S2_med_007.txt','',5,0); 
%                 dlmread('S1_med_008.txt','',5,0), dlmread('S2_med_008.txt','',5,0)}; 
%               
% end