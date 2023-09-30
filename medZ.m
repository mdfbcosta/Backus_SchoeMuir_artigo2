close all
clear all
clc

% Leitura dos valores das amostras de referência
load('vel_ref.txt');               % Velocidades
load('den_ref.txt');               % Densidades
load('zi.txt');                    % Espessura das camadas
load('ncam.txt'); ncam = ncam';    % Número de camadas


%% ========================================================================
%                       MODELO COM FISSURAS
%% ======================================================================== 

% __________ MEDIDAS NA DIREÇÃO X e Z - VELOCIDADE DE ONDA P e S __________

% Tempos de trânsito e densidade
tpz_100_cf  = load('tpz_100k_cfiss.txt') ;     % tempo P - Vertical
tpx_100_cf  = load('tpx_100k_cfiss.txt') ;     % tempo P - Horizontal
tpz_500_cf  = load('tpz_500k_cfiss.txt') ;     % tempo P - Vertical
tsz_500_cf  = load('tsz_500k_cfiss.txt') ;     % tempo S - Vertical
tpz_1000_cf = load('tpz_1000k_cfiss(2).txt');  % tempo P - Vertical
tsz_1000_cf = load('tsz_1000k_cfiss(2).txt');  % tempo S - Vertical
tpx_1000_cf = load('tpx_1000k_cfiss.txt');     % tempo P - Horizontal
tsh_1000_cf = load('tsh_1000k_cfiss.txt');     % tempo S - Horizontal
tsv_1000_cf = load('tsv_1000k_cfiss.txt');     % tempo S - Horizontal
rho_cf      = load('rho_cfiss.txt')      ;     % densidade

t1k_cf = tpz_100_cf;
t5k_cf = tpz_500_cf;
t1m_cf = tpz_1000_cf;

% Vetores espaço percorrido e nº camadas correspondentes
ncam_dimX_1000k = [91 100 110 121 132 143 154 164 174];
z_cf        = load('dimZ_cfiss.txt')     ;   % Offset  - Vertical
x_cf        = load('dimX_cfiss.txt')     ;   % Offset  - Horizontal
x_1000k_cf  = load('dimX_1000k_cfiss.txt');  % Offset  - Horizontal
ncamZ_cf    = load('ncamZ_cfiss.txt')    ;   % Nº de camadas das medidas
d           = load('depth_cfiss.txt')    ;   % Profundidade - Z
%ncam_d = floor(d/zi)+1;  % Correspondência entre profundidade e nº camadas
ncam_d = [13 29 45 61 77 93 117 133 149]';
save('ncam_d.txt','ncam_d','-ascii');
n = [35 32 28 24 21 18 16 12 10 8 6 4 2]'; % apenas medidas novas 1000 kHz

f = numel(z_cf);
i_500  = f - numel(tpz_500_cf) +1;
i_1000 = f - numel(tpz_1000_cf)+1;

% Correções segundo a curva de tendência
tpz_100_cf(16:f) = tpz_100_cf(16:f)+linspace(15,2,7)';
tpz_100_cf(9:15) = tpz_100_cf(9:15)+linspace(35,30,7)';
tpz_100_cf(20:22) = tpz_100_cf(20:22) + 1;
tpz_100_cf(17) = tpz_100_cf(17) + 5;
tpz_100_cf(14:15) = tpz_100_cf(14:15) - 8;
tpz_100_cf(12:13) = tpz_100_cf(12:13) + 10;
tpz_100_cf(9) = tpz_100_cf(9) - 10;
tpz_100_cf(7:8) = tpz_100_cf(7:8) - 25;
tpz_100_cf(6) = tpz_100_cf(6) - 15;
tpz_100_cf(5) = tpz_100_cf(5) + 15;
tpz_100_cf = tpz_100_cf*0.75;

tpx_100_cf(5:6) = tpx_100_cf(5:6) - 0.8; % Espessura na direção: dimX.
tpx_100_cf(1:3) = tpx_100_cf(1:3)*1.035;

tpz_500_cf = tpz_500_cf + linspace(25,3,numel(tpz_500_cf))';
tpz_500_cf(4:5) = tpz_500_cf(4:5)+2.8;
tpz_500_cf(7) = tpz_500_cf(7)+3.5;
tpz_500_cf(10) = tpz_500_cf(10)+0.8;
tpz_500_cf(1:5) = tpz_500_cf(1:5)*0.75;
tpz_500_cf(6:10) = tpz_500_cf(6:10)*0.70;

tsz_500_cf = tsz_500_cf + linspace(30,5,numel(tsz_500_cf))';
tsz_500_cf(6) = tsz_500_cf(6)*0.80;
tsz_500_cf(1) = tsz_500_cf(1)*0.90;
tsz_500_cf = tsz_500_cf*0.95;

tpz_1000_cf = tpz_1000_cf + linspace(8,0.5,numel(tpz_1000_cf))';
tpz_1000_cf(5:13) = tpz_1000_cf(5:13) + linspace(1.5,0.2,9)';
tpz_1000_cf(3:6) = tpz_1000_cf(3:6) - 2;
tpz_1000_cf(1) = tpz_1000_cf(1) + 2;
tpz_1000_cf(2) = tpz_1000_cf(2) + 5;
tpz_1000_cf = tpz_1000_cf*0.75;

tpx_1000_cf(4:9) = tpx_1000_cf(4:9) + linspace(-2,-1,numel(tpx_1000_cf(4:9)))'; % correção
tpx_1000_cf(8:9) = tpx_1000_cf(8:9) - 2;
tpx_1000_cf(5:6) = tpx_1000_cf(5:6) - 2;
tpx_1000_cf(1:5) = tpx_1000_cf(1:5)*0.95;

tsh_1000_cf(3:4) = tsh_1000_cf(3:4) -3; % correção
tsh_1000_cf(5) = tsh_1000_cf(5) -7; % correção
tsh_1000_cf(8:9) = tsh_1000_cf(8:9) -5; % correção
tsh_1000_cf(6) = tsh_1000_cf(6) - 12;
tsh_1000_cf(1) = tsh_1000_cf(1) - 1.0;
tsh_1000_cf(3) = tsh_1000_cf(3) + 2.5;

tsz_1000_cf(6) = tsz_1000_cf(6) - 1.5; % correção
tsz_1000_cf(7:9) = tsz_1000_cf(7:9) + linspace(3,2.5,3)'; % correção
tsz_1000_cf(10:13) = tsz_1000_cf(10:13) + 0.5; % correção
tsz_1000_cf(1:4) = tsz_1000_cf(1:4) + [3 3 -3 -3]'; % correção
tsz_1000_cf = tsz_1000_cf.*linspace(0.9,0.95,numel(tsz_1000_cf))';
tsz_1000_cf = tsz_1000_cf.*linspace(1.03,1.0,numel(tsz_1000_cf))';

tsv_1000_cf(1:4) = tsv_1000_cf(1:4) + [5 10 10 1]'; % correção
tsv_1000_cf(6:9) = tsv_1000_cf(6:9) + [-6 12 3 11]'; % correção
tsv_1000_cf(1:3) = tsv_1000_cf(1:3) - [1 1 4]';
tsv_1000_cf = tsv_1000_cf*0.925;

rho_cf(20:22) = 0.937*rho_cf(20:22);
rho_cf(18:19) = 0.915*rho_cf(18:19);
rho_cf(16:17) = 0.937*rho_cf(16:17);
rho_cf(13:15) = 0.920*rho_cf(13:15);
rho_cf(6:12)  = 0.937*rho_cf(6:12);
rho_cf(4:5)   = 0.932*rho_cf(4:5);
rho_cf(2:3)   = 0.910*rho_cf(2:3);
rho_cf(1)     = 0.925*rho_cf(1);
rho_cf(10) = (rho_cf(11)+rho_cf(12))/2; % Correção
rho_cf(9) = (rho_cf(10)+rho_cf(8))/2;   % Correção

% Relação corrigido/não-corrigido
cf1 = tpz_100_cf./t1k_cf;  cf1 = flip(cf1);
cf2 = tpz_500_cf./t5k_cf;  cf2 = flip(cf2);
cf3 = tpz_1000_cf./t1m_cf; cf3 = flip(cf3);

% Cálculo da velocidade
vpz_100_cf  = z_cf./tpz_100_cf *1000; vpz_100_cf = flip(vpz_100_cf);
vpx_100_cf  = x_cf./tpx_100_cf *1000; vpx_100_cf = flip(vpx_100_cf);
vpz_1000_cf = (n*2.045)./tpz_1000_cf*1000; vpz_1000_cf = flip(vpz_1000_cf);
vsz_1000_cf = (n*2.045)./tsz_1000_cf*1000; vsz_1000_cf = flip(vsz_1000_cf);
vpx_1000_cf = x_1000k_cf./tpx_1000_cf *1000; vpx_1000_cf = flip(vpx_1000_cf);
vsh_1000_cf = x_1000k_cf./tsh_1000_cf *1000; vsh_1000_cf = flip(vsh_1000_cf);
vsv_1000_cf = x_1000k_cf./tsv_1000_cf *1000; vsv_1000_cf = flip(vsv_1000_cf);
vpz_500_cf  = z_cf(i_500:f)./tpz_500_cf *1000; vpz_500_cf  = flip(vpz_500_cf);
vsz_500_cf  = z_cf(i_500:f)./tsz_500_cf *1000; vsz_500_cf  = flip(vsz_500_cf);
ro_cf = flip(rho_cf);

save('vpz_1k_cf.txt','vpz_100_cf','-ascii');
save('vpx_1k_cf.txt','vpx_100_cf','-ascii');
save('vpz_1M_cf.txt','vpz_1000_cf','-ascii');
save('vsz_1M_cf.txt','vsz_1000_cf','-ascii');
save('vpx_1M_cf.txt','vpx_1000_cf','-ascii');
save('vsh_1M_cf.txt','vsh_1000_cf','-ascii');
save('vsv_1M_cf.txt','vsv_1000_cf','-ascii');
save('vpz_5k_cf.txt','vpz_500_cf','-ascii');
save('vsz_5k_cf.txt','vsz_500_cf','-ascii');

save('tpz_100_cf.txt','tpz_100_cf','-ascii');
save('tpz_500_cf.txt','tpz_500_cf','-ascii');
save('tpz_1000_cf.txt','tpz_1000_cf','-ascii');


%% ========================================================================
%                         MODELO SEM FISSURA: BACKGROUND
%% ======================================================================== 

% __________ MEDIDAS NA DIREÇÃO X e Z - VELOCIDADE DE ONDA P e S __________

% Tempos de trânsito e densidade
tpz_100_sf  = load('tpz_100k_sfiss.txt') ;   % tempo P - Vertical
tpx_100_sf  = load('tpx_100k_sfiss.txt') ;   % tempo P - Horizontal
tpz_500_sf  = load('tpz_500k_sfiss.txt') ;   % tempo P - Vertical
tsz_500_sf  = load('tsz_500k_sfiss.txt') ;   % tempo S - Vertical
tpz_1000_sf = load('tpz_1000k_sfiss.txt');   % tempo P - Vertical
tsz_1000_sf = load('tsz_1000k_sfiss.txt');   % tempo S - Vertical
tpx_1000_sf  = load('tpx_1000k_sfiss.txt');  % tempo P - Horizontal
tsh_1000_sf  = load('tsh_1000k_sfiss.txt');  % tempo S - Horizontal
tsv_1000_sf  = load('tsv_1000k_sfiss.txt');  % tempo S - Horizontal
rho_sf      = load('rho_sfiss(2).txt')    ;  % densidade

t1k_sf = tpz_100_sf;
t5k_sf = tpz_500_sf;
t1m_sf = tpz_1000_sf;

% Vetores espaço percorrido e nº camadas correspondentes
ncam_dimX_1000k = [91 100 110 121 132 143 154 164 174];
z_sf        = load('dimZ_sfiss.txt')      ;   % Offset  - Vertical
x_sf        = load('dimX_sfiss.txt')      ;   % Offset  - Horizontal
x_1000k_sf  = load('dimX_1000k_sfiss.txt');   % Offset  - Horizontal
ncamZ_sf    = load('ncamZ_sfiss.txt')     ;   % Nº de camadas das medidas

fs = numel(z_sf);
is_500  = fs - numel(tpz_500_sf) +1;
is_1000 = fs - numel(tpz_1000_sf)+1;

% Correções no tempo de chegada baseada curva de tendência
tpz_100_sf(18:fs) = tpz_100_sf(18:fs) + linspace(2.5,0,8)';
tpz_100_sf(9:17)  = tpz_100_sf(9:17) + linspace(15,7.5,9)';
tpx_100_sf(5:9)   = tpx_100_sf(5:9) + 2; % Obser. espessura de dimX.
tsz_500_sf(14:16) = tsz_500_sf(14:16) + linspace(2,0.5,3)';
tsz_500_sf(10:13) = tsz_500_sf(10:13) + linspace(6,5,4)';
tpz_500_sf(16)   = tpz_500_sf(16) - 0.5;
tpz_500_sf(15)   = tpz_500_sf(15) - 0.0;
tpz_500_sf(5:6)  = tpz_500_sf(5:6) - 3;
tpz_500_sf(7:8)  = tpz_500_sf(7:8) + 2;
tpz_1000_sf = tpz_1000_sf + linspace(-10,0,numel(tpz_1000_sf))';
tpz_1000_sf(7:13)  = tpz_1000_sf(7:13) + 1;
tpx_1000_sf = tpx_1000_sf + linspace(-5,-1,numel(tpx_1000_sf))'; % correção
tpx_1000_sf(4:9)   = tpx_1000_sf(4:9) + linspace(-2,0,numel(tpx_1000_sf(4:9)))'; % correção
tpx_1000_sf(7:8)   = tpx_1000_sf(7:8) - 1; % correção

tsh_1000_sf = tsh_1000_sf + linspace(-7.5,-1,numel(tsh_1000_sf))'; % correção
tsh_1000_sf(4:9) = tsh_1000_sf(4:9) + linspace(-3,0,numel(tsh_1000_sf(4:9)))'; % correção
tsh_1000_sf(1) = tsh_1000_sf(1) - 2.0;
tsh_1000_sf(2:3) = tsh_1000_sf(2:3) + [1.5 2.0]';
tsh_1000_sf(7) = tsh_1000_sf(7) - 2.0;

tsz_1000_sf(9:11) = tsz_1000_sf(9:11) - 5; % correção
tsz_1000_sf(13:14) = tsz_1000_sf(13:14) + 1; % correção
tsz_1000_sf(16) = tsz_1000_sf(16) + 1; % correção
tsz_1000_sf(15) = tsz_1000_sf(15) + 4; % correção
tsz_1000_sf(6:8) = tsz_1000_sf(6:8) + 5; % correção
tsz_1000_sf(1:2) = tsz_1000_sf(1:2) + [10 23]'; % correção
tsz_1000_sf = tsz_1000_sf*1.08;

tsv_1000_sf(1:3) = tsv_1000_sf(1:3) +[-6 3 3]'; % correção
tsv_1000_sf(3:5) = tsv_1000_sf(3:5) - [5 8 8]'; % correção
tsv_1000_sf(8:9) = tsv_1000_sf(8:9) + [4 5]'; % correção

rho_sf(6) = (rho_sf(7)+rho_sf(5))/2;    % Correção

% Relação corrigido/não-corrigido
sf1 = tpz_100_sf(4:25)./t1k_sf(4:25);  sf1 = flip(sf1);
sf2 = tpz_500_sf./t5k_sf;              sf2 = flip(sf2);
sf3 = tpz_1000_sf./t1m_sf;             sf3 = flip(sf3);

% Cálculo das velocidades
vpz_100_sf  = z_sf(4:25)./tpz_100_sf(4:25)*1000; vpz_100_sf = flip(vpz_100_sf);
vpx_100_sf  = x_sf./tpx_100_sf *1000; vpx_100_sf = flip(vpx_100_sf);
vpz_1000_sf = z_sf(is_1000:fs)./tpz_1000_sf*1000; vpz_1000_sf = flip(vpz_1000_sf);
vsz_1000_sf = z_sf(is_1000:fs)./tsz_1000_sf*1000; vsz_1000_sf = flip(vsz_1000_sf);
vpx_1000_sf = x_1000k_sf./tpx_1000_sf *1000; vpx_1000_sf = flip(vpx_1000_sf);
vsh_1000_sf = x_1000k_sf./tsh_1000_sf *1000; vsh_1000_sf = flip(vsh_1000_sf);
vsv_1000_sf = x_1000k_sf./tsv_1000_sf *1000; vsv_1000_sf = flip(vsv_1000_sf);
vpz_500_sf  = z_sf(is_500:fs)./tpz_500_sf *1000; vpz_500_sf = flip(vpz_500_sf);
vsz_500_sf  = z_sf(is_500:fs)./tsz_500_sf *1000; vsz_500_sf = flip(vsz_500_sf);
ro_sf = flip(rho_sf(4:25));

save('vpz_1k_sf.txt','vpz_100_sf','-ascii');
save('vpx_1k_sf.txt','vpx_100_sf','-ascii');
save('vpz_1M_sf.txt','vpz_1000_sf','-ascii');
save('vsz_1M_sf.txt','vsz_1000_sf','-ascii');
save('vpx_1M_sf.txt','vpx_1000_sf','-ascii');
save('vsh_1M_sf.txt','vsh_1000_sf','-ascii');
save('vsv_1M_sf.txt','vsv_1000_sf','-ascii');
save('vpz_5k_sf.txt','vpz_500_sf','-ascii');
save('vsz_5k_sf.txt','vsz_500_sf','-ascii');


%% ========================================================================
%                             BACKUS SEM FISSURA
%% ======================================================================== 

load('ro_ef_sf.txt'); ro_ef_sf = ro_ef_sf/1000;

load('vpz_bk_100.txt')
load('vpx_bk_100.txt')
load('vsz_bk_100.txt');
load('vsh_bk_100.txt');

load('vpz_bk_500.txt');
load('vpx_bk_500.txt');
load('vsz_bk_500.txt');
load('vsh_bk_500.txt');

load('vpz_bk_1000.txt');
load('vpx_bk_1000.txt');
load('vsz_bk_1000.txt');
load('vsh_bk_1000.txt');


%% ========================================================================
%                             BAKULIN -- FISSURA
%% ======================================================================== 

load('ro_ef_cf.txt'); ro_ef_cf = ro_ef_cf/1000;

load('vpz_bl_100.txt')
load('vpx_bl_100.txt')
load('vsh_bl_100.txt');
load('vsv_bl_100.txt');

load('vpz_bl_500.txt')
load('vpx_bl_500.txt')
load('vsh_bl_500.txt')
load('vsv_bl_500.txt')

load('vpz_bl_1000.txt')
load('vpx_bl_1000.txt')
load('vsh_bl_1000.txt')
load('vsv_bl_1000.txt')


%% ========================================================================
%                 OS CINCO PARÂMETROS DE ELASTICOS: C_{IJ}
%% ======================================================================== 

%OBS.: Não temos medidas com 45°, logo não podemos calcular C13;

% Para 100 kHz
pont = [13 29 45 61 77 93 117 133 149];
for i = 1:numel(pont)
    ind(i) = find(ncam == pont(i));
end

C11sf_1k = (vpx_100_sf.^2).*ro_sf(ind)*1000;
C33sf_1k = (vpz_100_sf.^2).*ro_sf*1000;
C11cf_1k = (vpx_100_cf.^2).*ro_sf(ind)*1000;
C33cf_1k = (vpz_100_cf.^2).*ro_cf*1000;

% Para 500 kHz
pont1 = [5 13 21 29 37 45 53 61 69 77];
for i = 1:numel(pont1)
    ind1(i) = find(ncam == pont1(i));
end
pont2 = [5 13 21 29 37 45 53 61 69 77 85 93 101 109 117 125];
for i = 1:numel(pont2)
    ind2(i) = find(ncam == pont2(i));
end
 C33sf_5k = (vpz_500_sf.^2).*ro_sf(ind2)*1000;
 C44sf_5k = (vsz_500_sf.^2).*ro_sf(ind2)*1000;
 C33cf_5k = (vpz_500_cf.^2).*ro_cf(ind1)*1000;
 C44cf_5k = (vsz_500_cf.^2).*ro_cf(ind1)*1000;

% Para 1 MHz
pont3 = [13 29 45 61 77 93 117 133 149];
for i = 1:numel(pont3)
    ind3(i) = find(ncam == pont3(i));
end
pont4 = [5 13 21 29 37 45 53 61 69 77 85 93];
for i = 1:numel(pont4)
    ind4(i) = find(ncam == pont4(i));
end
ind5 = ind4(1:numel(ind4)-2);
 C11sf_1m = (vpx_1000_sf.^2).*ro_sf(ind3)*1000;
 C33sf_1m = (vpz_1000_sf(ind4).^2).*ro_sf(ind4)*1000;
 C44sf_1m = (vsv_1000_sf.^2).*ro_sf(ind3)*1000;
 C66sf_1m = (vsh_1000_sf.^2).*ro_sf(ind3)*1000;
 C11cf_1m = (vpx_1000_cf.^2).*ro_cf(ind3)*1000;
 C33cf_1m = (vpz_1000_cf(ind5).^2).*ro_cf(ind5)*1000;
 C44cf_1m = (vsv_1000_cf.^2).*ro_cf(ind3)*1000;
 C66cf_1m = (vsh_1000_cf.^2).*ro_cf(ind3)*1000;

% *vsz_1000_sf


%% ========================================================================
%                             PARÂMETROS DE THOMSEN
%% ======================================================================== 

% Teóricos
load('e_sf_1k.txt'); load('g_sf_1k.txt'); load('d_sf_1k.txt');
load('e_cf_1k.txt'); load('g_cf_1k.txt'); load('d_cf_1k.txt');
load('e_sf_5k.txt'); load('g_sf_5k.txt'); load('d_sf_5k.txt');
load('e_cf_5k.txt'); load('g_cf_5k.txt'); load('d_cf_5k.txt');
load('e_sf_1M.txt'); load('g_sf_1M.txt'); load('d_sf_1M.txt');
load('e_cf_1M.txt'); load('g_cf_1M.txt'); load('d_cf_1M.txt');

% Experimentais
in = [2 4 6 8 10 12 15 17 19]; % indices: correspondência entre medidas em Z e X.
[ep_sf_1k,ep_cf_1k] = ep_exp (in,vpz_100_sf,vpx_100_sf,vpz_100_cf,vpx_100_cf);
[ep_sf_1M,ep_cf_1M] = ep_exp (in(1:6),vpz_1000_sf,vpx_1000_sf(1:6),vpz_1000_cf,vpx_1000_cf(1:6));
[ga_sf_1M,ga_cf_1M] = ga_exp (vsh_1000_sf,vsv_1000_sf,vsh_1000_cf,vsv_1000_cf);



%% ========================================================================
%                           RAZÃO DE BACKUS (Lambda/d)
%% ======================================================================== 

load('freqdom_cf.txt'); fd_cf = flip(freqdom_cf);
load('freqdom_sf.txt'); fd_sf = flip(freqdom_sf);

r_100_sf  = (vpz_100_sf.*sf1) ./(fd_sf(1:numel(vpz_100_sf),2) *2*zi);
r_500_sf  = (vpz_500_sf.*sf2) ./(fd_sf(1:numel(vpz_500_sf),3) *2*zi);
r_1000_sf = (vpz_1000_sf.*sf3)./(fd_sf(1:numel(vpz_1000_sf),4)*2*zi);

r_100_cf  = (vpz_100_cf.*cf1) ./(fd_cf(1:numel(vpz_100_cf) ,2)*2*zi);
r_500_cf  = (vpz_500_cf.*cf2) ./(fd_cf(1:numel(vpz_500_cf) ,3)*2*zi);
r_1000_cf = (vpz_1000_cf.*cf3)./(fd_cf(1:numel(vpz_1000_cf),4)*2*zi);


%%%%%%%%%%%%%%%%%%
%% GRÁFICOS
%%%%%%%%%%%%%%%%%%


%% 100 kHz
fig10 = figure(10)

subplot(1,3,1)
hold on
plot(vpz_100_cf,ncam,'ob','MarkerFaceColor',[0,0,1])
plot(vpz_100_sf,ncam,'or','MarkerFaceColor',[1,0,0])
plot(vpz_bl_100,ncam,'--b')
plot(vpz_bk_100,ncam,'--r')
plot(vel_ref(1,1),90,'og','MarkerFaceColor',[0,1,1])
plot(vel_ref(2,1),90,'vg','MarkerFaceColor',[0,1,1])
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
xlim([1000 vel_ref(1,1)*1.1])
title('V_{PZ} 100 kHz')
xlabel('Velocity [m/s]')
ylabel('Number of Layers')
grid on; box on

subplot(1,3,2)
hold on
plot(vpx_100_cf,ncam_d,'ob','MarkerFaceColor',[0,0,1])
plot(vpx_100_sf,ncam_d,'or','MarkerFaceColor',[1,0,0])
plot(vpx_bl_100,ncam,'--b')
plot(vpx_bk_100,ncam,'--r')
plot(vel_ref(1,1),90,'og','MarkerFaceColor',[0,1,1])
plot(vel_ref(2,1),90,'vg','MarkerFaceColor',[0,1,1])
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
xlim([1000 vel_ref(1,1)*1.1])
title('V_{PX} 100 kHz')
ylim([0 180])
xlim([1950 3000])
xlabel('Velocity [m/s]')
leg1 = legend('Cracked','Uncracked','Bkus cracked','Bkus uncracked')
set(leg1,...
    'Position',[0.258216956020854 0.14831567897635 0.336363629409761 0.074730352370875],...
    'NumColumns',2,'FontSize',13);
grid on; box on

subplot(1,3,3)
hold on
plot(ro_cf,ncam,'ob','MarkerFaceColor',[0,0,1])
plot(ro_sf,ncam,'or','MarkerFaceColor',[1,0,0])
plot(ro_ef_cf,ncam,'--b')
plot(ro_ef_sf,ncam,'--r')
plot(1.48,90,'og','MarkerFaceColor',[0,1,1])
plot(1.64,90,'vg','MarkerFaceColor',[0,1,1])
annotation(fig10,'textbox',...
    [0.837293729372937 0.52080123367589 0.0488448844884491 0.0493066245675639],...
    'String','1.88',...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);
annotation(fig10,'textbox',...
    [0.695749574957495 0.523882896764254 0.0488048804880492 0.0462249614792009],...
    'String',{'1.18'},...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);
xlim([1.45 1.65])
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
title('\rho')
xlabel('Density [g/cm3]')
leg1 = legend('Cracked','Uncracked','ave. cracked','ave. uncracked')
set(leg1,...
    'Position',[0.788003954984964 0.146004431912638 0.185858581854839 0.144067792569177],...
    'FontSize',13);
grid on; box on


set(gcf,'Position',[50 50 1000 1000])

%% 500 kHz
figure(20)

subplot(1,2,1)
hold on
plot(vpz_500_cf,ncam(1:numel(vpz_500_cf)),'ob','MarkerFaceColor',[0,0,1])
plot(vpz_500_sf,ncam(1:numel(vpz_500_sf)),'or','MarkerFaceColor',[1,0,0])
plot(vpz_bl_500,ncam,'--b')
plot(vpz_bk_500,ncam,'--r')
plot(vel_ref(1,3),90,'og','MarkerFaceColor',[0,1,1])
plot(vel_ref(2,3),90,'vg','MarkerFaceColor',[0,1,1])
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
xlim([1500 vel_ref(1,3)*1.025])
title('V_{PZ} 500 kHz')
xlabel('Velocity [m/s]')
ylabel('Number of Layers')
grid on; box on

subplot(1,2,2)
hold on
plot(vsz_500_cf,ncam(1:numel(vsz_500_cf)),'ob','MarkerFaceColor',[0,0,1])
plot(vsz_500_sf,ncam(1:numel(vsz_500_sf)),'or','MarkerFaceColor',[1,0,0])
plot(vsv_bl_500,ncam,'--b')
plot(vsz_bk_500,ncam,'--r')
plot(vel_ref(1,4),90,'og','MarkerFaceColor',[0,1,1])
plot(vel_ref(2,4),90,'vg','MarkerFaceColor',[0,1,1])
xlim([1000 2000])
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
title('V_{SZ} 500 kHz')
xlabel('Velocity [m/s]')
leg1 = legend('Cracked','Uncracked','Bkus cracked','Bkus uncracked')
set(leg1,...
    'Position',[0.246342775021141 0.148225636603469 0.56440676799265 0.0747303523708749],...
    'NumColumns',2,...
    'FontSize',13);
grid on; box on

set(gcf,'Position',[50 50 580 1000])

%% 1 MHz
figure(30)

subplot(1,4,1)
hold on
plot(vpz_1000_cf(1:numel(vpz_1000_cf)-3),ncam(1:numel(vpz_1000_cf)-3),'ob','MarkerFaceColor',[0,0,1])
plot(vpz_1000_sf(1:numel(vpz_1000_sf)-4),ncam(1:numel(vpz_1000_sf)-4),'or','MarkerFaceColor',[1,0,0])
plot(vpz_bl_1000,ncam,'--b')
plot(vpz_bk_1000,ncam,'--r')
plot(vel_ref(1,5),90,'og','MarkerFaceColor',[0,1,1])
plot(vel_ref(2,5),90,'vg','MarkerFaceColor',[0,1,1])
xlim([2000 3500])
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
title('V_{PZ} 1 MHz')
xlabel('Velocity [m/s]')
ylabel('Number of layers')
grid on; box on

subplot(1,4,2)
hold on
plot(vpx_1000_cf,ncam_d,'ob','MarkerFaceColor',[0,0,1])
plot(vpx_1000_sf,ncam_d,'or','MarkerFaceColor',[1,0,0])
plot(vpx_bl_1000,ncam,'--b')
plot(vpx_bk_1000,ncam,'--r')
plot(vel_ref(1,5),90,'og','MarkerFaceColor',[0,1,1])
plot(vel_ref(2,5),90,'vg','MarkerFaceColor',[0,1,1])
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
xlim([2000 3500])
title('V_{PX} 1 MHz')
xlabel('Velocity [m/s]')
grid on; box on

subplot(1,4,3)
hold on
plot(vsh_1000_cf,ncam_d,'ob','MarkerFaceColor',[0,0,1])
plot(vsh_1000_sf,ncam_d,'or','MarkerFaceColor',[1,0,0])
plot(vsh_bl_1000,ncam,'--b')
plot(vsh_bk_1000,ncam,'--r')
plot(vel_ref(1,6),90,'og','MarkerFaceColor',[0,1,1])
plot(vel_ref(2,6),90,'vg','MarkerFaceColor',[0,1,1])
xlim([1200 2000])
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
title('V_{SH} 1 MHz')
xlabel('Velocity [m/s]')
%ylabel('Number of Layers')
leg1 = legend('Cracked','Uncracked','Bkus cracked','Bkus uncracked')
set(leg1,...
    'Position',[0.249521901281243 0.146635848556229 0.329344867478328 0.074730352370875],...
    'NumColumns',2,'FontSize',13);
grid on; box on

subplot(1,4,4)
hold on
plot(vsz_1000_cf(1:numel(vsz_1000_cf)-2),ncam(1:numel(vsz_1000_cf)-2),'ob')
plot(vsz_1000_sf(1:numel(vsz_1000_sf)-4),ncam(1:numel(vsz_1000_sf)-4),'or')
plot(vsv_1000_cf,ncam_d,'ob','MarkerFaceColor',[0 0 1])
plot(vsv_1000_sf,ncam_d,'or','MarkerFaceColor',[1 0 0])
plot(vsv_bl_1000,ncam,'--b')
plot(vsz_bk_1000,ncam,'--r')
plot(vel_ref(1,6),90,'og','MarkerFaceColor',[0 1 1])
plot(vel_ref(2,6),90,'vg','MarkerFaceColor',[0 1 1])
xlim([1200 2000])
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
title('V_{SZ} 1 MHz')
xlabel('Velocity [m/s]')
leg1 = legend('V_{SZ} cracked','V_{SZ} uncracked','V_{SV} cracked','V_{SV} uncracked','Bkus cracked','Bkus uncracked','Location','Best')
set(leg1,'FontSize',13,...
    'Position',[0.829494491645924 0.126924117924803 0.128637057054463 0.271956848896156]);
grid on; box on


set(gcf,'Position',[50 50 1500 1000])


%% PARÂMETROS DE THOMSEN

% Regressão polinomial com pesos
%var = [2 4 6 8 10 12 15 17 19];
%[Z1,W1,rmse(1)] = reg_polyn_pesos(ncam_d,ep_sf_1k,ncam(var),e_sf_1k(var))

% Regressão polinomial
var = [2 3 4 5 6 7 9];
[Z1,W1,rmse(1)] = reg_polyn(ncam_d(var),ep_sf_1k(var),1);
var = [3 4 6 7 8 9];
[Z2,W2,rmse(2)] = reg_polyn(ncam_d(var),ep_cf_1k(var),1);
var = [2 3 4 5];
[Z3,W3,rmse(3)] = reg_polyn(ncam_d(var),ep_sf_1M(var),1);
var = [3 4 5];
[Z4,W4,rmse(4)] = reg_polyn(ncam_d(var),ep_cf_1M(var),1);
var = [1 3 4 6 7 8];
[Z5,W5,rmse(5)] = reg_polyn(ncam_d(var),ga_sf_1M(var),1);
var = [2 3 4 5 8];
[Z6,W6,rmse(6)] = reg_polyn(ncam_d(var),ga_cf_1M(var),1);

% Regressão linear
%[Z1] = reg_linear(ncam_d,ep_sf_1k);

fig1 = figure(40)

subplot(1,3,1) % 100 kHz
hold on
plot(ep_sf_1k,ncam_d,'or','MarkerFaceColor',[1 0 0])
plot(ep_cf_1k,ncam_d,'ob','MarkerFaceColor',[0 0 1])
plot(Z1,W1,'--r', 'LineWidth', 2); % Linha de regressão
plot(Z2,W2,'--b', 'LineWidth', 2); % Linha de regressão
plot(e_sf_1k,ncam,'.-r')
plot(e_cf_1k,ncam,'.-b')
set(gca,'FontSize',16)
set(gca,'YDir','reverse')
xlabel('Anisotropic parameter')
ylabel('Number of Layers')
leg1 = legend('exp. uncracked','exp. cracked','Location','Best')
title(leg1,'100 kHz')
title('$\epsilon = \frac{C_{11} - C_{33}}{2 C_{33}}$','Interpreter', 'latex')
grid on; box on
xlim([-0.2 0.6])
texto = [num2str(rmse(1))];
annotation('textbox',[0.1447 0.7265 0.077 0.05],...
    'String',texto,'FontSize',14,'EdgeColor', 'none',...
    'BackgroundColor',[1 1 1])
texto = [num2str(rmse(2))];
annotation('textbox',[0.3001 0.5863 0.0770 0.05],...
    'String',texto,'FontSize',14,'EdgeColor', 'none',...
    'BackgroundColor',[1 1 1])

subplot(1,3,2) % 1000 kHz
hold on
plot(ep_sf_1M,ncam_d(1:numel(ep_sf_1M)),'or','MarkerFaceColor',[1 0 0])
plot(ep_cf_1M(1:numel(ep_cf_1M)-1),ncam_d(1:numel(ep_cf_1M)-1),'ob','MarkerFaceColor',[0 0 1])
plot(Z3,W3,'--r', 'LineWidth', 2); % Linha de regressão
plot(Z4,W4,'--b', 'LineWidth', 2); % Linha de regressão
plot(e_sf_1M,ncam,'.-r')
plot(e_cf_1M,ncam,'.-b')
set(gca,'FontSize',16)
set(gca,'YDir','reverse')
xlabel('Anisotropic parameter')
%leg1 = legend('exp. uncracked','exp. cracked','Location','Best')
%title(leg1,'1 MHz')
title('$\epsilon = \frac{C_{11} - C_{33}}{2 C_{33}}$','Interpreter', 'latex')
grid on; box on
xlim([-0.2 0.6])
texto = [num2str(rmse(3))];
annotation('textbox',[0.4158 0.4785 0.077 0.0500],...
    'String',texto,'FontSize',14,'EdgeColor', 'none',...
    'BackgroundColor',[1 1 1])
texto = [num2str(rmse(4))];
annotation('textbox',[0.5344 0.3891 0.0770 0.0499],...
    'String',texto,'FontSize',14,'EdgeColor', 'none',...
    'BackgroundColor',[1 1 1])

subplot(1,3,3) % 1000 kHz
hold on
plot(ga_sf_1M,ncam_d,'or','MarkerFaceColor',[1 0 0])
plot(ga_cf_1M,ncam_d,'ob','MarkerFaceColor',[0 0 1])
plot(Z5,W5,'--r', 'LineWidth', 2); % Linha de regressão
plot(Z6,W6,'--b', 'LineWidth', 2); % Linha de regressão
plot(g_sf_1M,ncam,'.-r')
plot(g_cf_1M,ncam,'.-b')
set(gca,'FontSize',16)
set(gca,'YDir','reverse')
xlabel('Number of Layers')
leg1 = legend('exp. uncracked','exp. cracked','Location','Best')
set(leg1,'Position',[0.507 0.137 0.298 0.083],'Orientation','horizontal');
title(leg1,'1 MHz')
title('$\gamma = \frac{C_{66} - C_{44}}{2 C_{44}}$','Interpreter', 'latex')
xlabel('Anisotropic parameter')
grid on; box on
xlim([0.1 0.4])
texto = [num2str(rmse(5))];
annotation('textbox',[0.7075 0.6418 0.077 0.0499],...
    'String',texto,'FontSize',14,'EdgeColor', 'none',...
    'BackgroundColor',[1 1 1])
texto = [num2str(rmse(6))];
annotation('textbox',[0.8277 0.5324 0.077 0.0499],...
    'String',texto,'FontSize',14,'EdgeColor', 'none',...
    'BackgroundColor',[1 1 1])


set(gcf,'Position',[50 50 1500 1000])


%% RAZÃO DE BACKUS
figure(50)

subplot(1,3,1) % 100 kHz
hold on
plot(r_100_sf,ncam,'or','MarkerFaceColor',[1 0 0])
plot(r_100_cf,ncam,'ob','MarkerFaceColor',[0 0 1])
plot(10*ones(numel(ncam),1),ncam,'k')
plot(3*ones(numel(ncam),1),ncam,'--k')
%leg1 = legend('uncracked','cracked','Mavko','Liner & Fei','Location','Best')
%title(leg1,'100 kHz')
xlim([0 45])
set(gca,'XTick',[0 3 10 20 30 40])
set(gca,'FontSize',16)
set(gca,'YDir','reverse')
xlabel('Ratio')
ylabel('Number of Layers')
title('(r = \lambda/d) 100 kHz')
grid on; box on

subplot(1,3,2) % 500 kHz
hold on
plot(r_500_sf,ncam(1:numel(r_500_sf)),'or','MarkerFaceColor',[1 0 0])
plot(r_500_cf,ncam(1:numel(r_500_cf)),'ob','MarkerFaceColor',[0 0 1])
plot(10*ones(numel(ncam),1),ncam,'k')
plot(3*ones(numel(ncam),1),ncam,'--k')
%leg1 = legend('uncracked','cracked','Mavko','Liner & Fei','Location','Best')
%title(leg1,'1 MHz')
xlim([0 45])
set(gca,'XTick',[0 3 10 20 30 40])
set(gca,'FontSize',16)
set(gca,'YDir','reverse')
xlabel('Ratio')
title('(r = \lambda/d) 500 kHz')
grid on; box on

subplot(1,3,3) % 1 MHz
hold on
plot(r_1000_sf,ncam(1:numel(r_1000_sf)),'or','MarkerFaceColor',[1 0 0])
plot(r_1000_cf,ncam(1:numel(r_1000_cf)),'ob','MarkerFaceColor',[0 0 1])
plot(10*ones(numel(ncam),1),ncam,'k')
plot(3*ones(numel(ncam),1),ncam,'--k')
leg1 = legend('uncracked','cracked','Mavko','Liner & Fei','Location','Best')
set(leg1,'Position',[0.313 0.143 0.419 0.041],'Orientation','horizontal');
xlim([0 45])
set(gca,'XTick',[0 3 10 20 30 40])
set(gca,'FontSize',16)
set(gca,'YDir','reverse')
xlabel('Ratio')
title('(r = \lambda/d) 1 MHz')
grid on; box on


set(gcf,'Position',[50 50 1500 1000])

%% velocidade vs razão Backus


figure(60)

% Veloc. Kennett
vpz_kn_1k = load('vpz_kn_1k.txt');
vpz_kn_5k = load('vpz_kn_5k.txt');
vpz_kn_1M = load('vpz_kn_1M.txt');
vp_ray1k = load('vp_ray1k.txt');
vp_ray5k = load('vp_ray5k.txt');
vp_ray1M = load('vp_ray1M.txt');


subplot(1,2,1)
hold on
plot([1:50],1882*ones(1,50),'--r','LineWidth',1)
plot([1:50],2190*ones(1,50),'--b','LineWidth',1)
plot([1:50],2258*ones(1,50),'--k','LineWidth',1)
plot((r_100_cf),vpz_100_cf,'or','MarkerFaceColor',[1,0,0])
plot((r_500_cf),vpz_500_cf,'ob','MarkerFaceColor',[0,0,1])
plot((r_1000_cf),vpz_1000_cf,'ok','MarkerFaceColor',[0,0,0])
leg1 = legend('100 kHz','500 kHz','1000 kHz')
title(leg1,'Cracked')
ylabel('V_{PZ} [m/s]')
xlabel('\lambda/d')
xlim([0 30])
ylim([1690 3200])
set(gca,'FontSize',16)
grid on; box on
annotation('line',[0.241960183767228 0.241910413476263],...
    [0.924499229583975 0.110148514851485])
annotation('textarrow',[0.288125 0.25],...
    [0.724247524752475 0.725247524752475],'String',{'Marion et al. (1994)'},...
    'FontSize',14);
annotation('textbox',...
    [0.063125 0.928455446540424 0.03531249913387 0.0457920782120511],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

subplot(1,2,2)
hold on
plot([1:50],2219*ones(1,50),'--r')
plot([1:50],2689*ones(1,50),'--b')
plot([1:50],2826*ones(1,50),'--k')
plot(linspace(1,50,numel(vpz_kn_1k)),vpz_kn_1k,'--r','LineWidth',1)
plot(linspace(1,50,numel(vpz_kn_5k)),vpz_kn_5k,'--b','LineWidth',1)
plot(linspace(1,50,numel(vpz_kn_1M)),vpz_kn_1M,'--k','LineWidth',1)
plot(linspace(1,50,numel(vp_ray1k)),vp_ray1k,'r','LineWidth',1)
plot(linspace(1,50,numel(vp_ray5k)),vp_ray5k,'b','LineWidth',1)
plot(linspace(1,50,numel(vp_ray1M)),vp_ray1M,'k','LineWidth',1)
plot((r_100_sf),vpz_100_sf,'or','MarkerFaceColor',[1,0,0])
plot((r_500_sf),vpz_500_sf,'ob','MarkerFaceColor',[0,0,1])
plot((r_1000_sf),vpz_1000_sf,'ok','MarkerFaceColor',[0,0,0])
leg2 = legend('100 kHz','500 kHz','1000 kHz')
title(leg2,'Uncracked')
ylabel('V_{PZ} [m/s]')
xlabel('\lambda/d')
xlim([0 30])
ylim([1690 3200])
set(gca,'FontSize',16)
grid on; box on
annotation('line',[0.682235834609495 0.68218606431853],...
    [0.924499229583975 0.110148514851485]);
annotation('textarrow',[0.721875 0.68375],...
    [0.188356435643564 0.189356435643564],'String',{'Marion et al. (1994)'},...
    'FontSize',14);
annotation('textbox',...
    [0.5025 0.930930694065177 0.0359374991152436 0.0457920782120511],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation('textbox',...
    [0.739375 0.345534654461216 0.17625 0.0457920782120511],...
    'String','Backus Effective Medium',...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman',...
    'FitBoxToText','off');
annotation('textbox',...
    [0.739375 0.47919802079785 0.17625 0.0457920782120511],...
    'String','Kennett''s theory',...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman',...
    'FitBoxToText','off');

set(gcf,'Position',[50 50 750 500])

% %%
% figure(100)
% ii = 6
% ff = 22;
% %vv = [vpz_100_cf(1:5) vpz_100_cf(7:14) vpz_100_cf(16:22)]
% ajust = fit(vpz_100_cf(ii:ff),r_100_cf(ii:ff),'poly3')
% plot(ajust,vpz_100_cf(ii:ff),r_100_cf(ii:ff))
% 
% %%



%% Parametros elásticos

%100 kHz

fig70 = figure(70)

subplot(3,2,1)
hold on
plot(ncam(ind),C11sf_1k/1.e9,'-ob')
plot(ncam,C33sf_1k/1.e9,'-or')%,'MarkerFaceColor',[1,0,0])
set(gca,'FontSize',16)
%ylim([2.2e9 1.8e10])
ylim([2.2 18])
xlim([0 179])
title('Uncracked')
%ylabel('Stiffness Coefficients [GPa]')
%xlabel('Number of Layers')
legend('C_{11}','C_{33}','C_{44}','C_{66}')
title(legend,'100 kHz')
grid on; box on

subplot(3,2,2)
hold on
plot(ncam(ind),C11cf_1k/1.e9,'-ob')
plot(ncam,C33cf_1k/1.e9,'-or')%,'MarkerFaceColor',[0,0,1])
set(gca,'FontSize',16)
%ylim([2.2e9 1.8e10])
ylim([2.2 18])
xlim([0 179])
title('Cracked')
%ylabel('C^{e}_{IJ} [GPa]')
%xlabel('Number of Layers')
legend('C_{11}','C_{33}','C_{44}','C_{66}')
title(legend,'100 kHz')
grid on; box on

subplot(3,2,3)
hold on
plot(ncam(ind2),C33sf_5k/1.e9,'-or')
plot(ncam(ind2),C44sf_5k/1.e9,'-og')%,'MarkerFaceColor',[1,0,0])
set(gca,'FontSize',16)
ylim([2.2 18])
xlim([0 179])
%title('Uncracked 100 kHz')
ylabel('Experimental Stiffness Coefficients [GPa]')
%xlabel('Number of Layers')
legend('C_{33}','C_{44}')
title(legend,'500 kHz')
grid on; box on

subplot(3,2,4)
hold on
plot(ncam(ind1),C33cf_5k/1.e9,'-or')
plot(ncam(ind1),C44cf_5k/1.e9,'-og')%,'MarkerFaceColor',[0,0,1])
set(gca,'FontSize',16)
%ylim([2.2e9 1.8e10])
ylim([2.2 18])
xlim([0 179])
%title('Cracked 100 kHz')
%ylabel('C^{e}_{IJ} [GPa]')
%xlabel('Number of Layers')
legend('C_{33}','C_{44}')
title(legend,'500 kHz')
grid on; box on

subplot(3,2,5)
hold on
plot(ncam(ind3),C11sf_1m/1.e9,'-ob')
plot(ncam(ind4),C33sf_1m/1.e9,'-or')
plot(ncam(ind3),C44sf_1m/1.e9,'-og')
plot(ncam(ind3),C66sf_1m/1.e9,'-ok')%,'MarkerFaceColor',[1,0,0])
set(gca,'FontSize',16)
%ylim([2.2e9 1.8e10])
ylim([2.2 18])
xlim([0 179])
%title('Uncracked 1 MHz')
%ylabel('Stiffness Coefficients [GPa]')
xlabel('Number of Layers')
legend('C_{11}','C_{33}','C_{44}','C_{66}')
title(legend,'1 MHz')
grid on; box on

subplot(3,2,6)
hold on
plot(ncam(ind3),C11cf_1m/1.e9,'-ob')
plot(ncam(ind5),C33cf_1m/1.e9,'-or')
plot(ncam(ind3),C44cf_1m/1.e9,'-og')
plot(ncam(ind3),C66cf_1m/1.e9,'-ok')%,'MarkerFaceColor',[1,0,0])
set(gca,'FontSize',16)
%ylim([2.2e9 1.8e10])
ylim([2.2 18])
xlim([0 179])
%title('Cracked 1 MHz')
%ylabel('C^{e}_{IJ} [GPa]')
xlabel('Number of Layers')
legend('C_{11}','C_{33}','C_{44}','C_{66}')
title(legend,'1 MHz')
grid on; box on

set(gcf,'Position',[50 50 1000 1200])