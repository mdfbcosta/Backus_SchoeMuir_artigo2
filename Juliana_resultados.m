% Dados do trabalho da Juliana (de 2019)

clear all
close all
clc
% ----------------------------------------

ab_1m = load('Juli_1M_abs_nVpVsvVsh.txt');
ab_5k = load('Juli_5k_abs_nVpVsvVsh.txt');
ac_1m = load('Juli_1M_acri_nVpVsvVsh.txt');
ac_5k = load('Juli_5k_acri_nVpVsvVsh.txt');

% ----------------------------------------

ncam_ab = ab_1m(:,1);
ncam_ac = ac_1m(:,1);

% Modelo ABS e RESINA
vpz_5k_ab = ab_5k(:,2); 
vsv_5k_ab = ab_5k(:,3);
vsh_5k_ab = ab_5k(:,4);
vpz_1m_ab = ab_1m(:,2);
vsv_1m_ab = ab_1m(:,3);
vsh_1m_ab = ab_1m(:,4);

% Modelo ACRILICO e RESINA+A.FINA
vpz_5k_ac = ac_5k(:,2); 
vsv_5k_ac = ac_5k(:,3);
vsh_5k_ac = ac_5k(:,4);
vpz_1m_ac = ac_1m(:,2);
vsv_1m_ac = ac_1m(:,3);
vsh_1m_ac = ac_1m(:,4);


% Modelo Acrilico e Resina+A.Fina
vp_ac5k	= 2564.60;
vs_ac5k	= 1296.37;
vp_ra5k = 3024.35;
vs_ra5k = 1421.44;
%
vp_ra1m	= 3299.82;
vs_ra1m = 1550.92;
vp_ac1m	= 2677.57;
vs_ac1m = 1309.95;
%
ro_ac	= 1.18;
ro_ra   = 1.57;

vel_1m = [vp_ac1m vs_ac1m; vp_ra1m vs_ra1m];
vel_5k = [vp_ac5k vs_ac5k; vp_ra5k vs_ra5k];
den = [ro_ac ro_ra];
ncam = [5:4:69];
z1 = 1*ones(1,ncam(numel(ncam)));
[vpz_bk_ac1m, vpx_bk_ac1m, vsh_bk_ac1m, vsv_bk_ac1m] = backus (vel_1m,den,ncam,z1);
[vpz_bk_ac5k, vpx_bk_ac5k, vsh_bk_ac5k, vsv_bk_ac5k] = backus (vel_5k,den,ncam,z1);


% Modelo PVC e Resina
vp_pv5k	= 2107.41;
vs_pv5k	= 943.29;
vp_re5k = 2536.66;
vs_re5k = 1190.54;
%
vp_re1m	= 2653.95;
vs_re1m = 1206.61;
vp_pv1m	= 2101.55;
vs_pv1m = 962.03;
%
ro_pv	= 1.093;
ro_re   = 1.155;

vel_1m = [vp_pv1m vs_pv1m; vp_re1m vs_re1m];
vel_5k = [vp_pv5k vs_pv5k; vp_re5k vs_re5k];
den = [ro_pv ro_re];
ncam = [5:4:69];
z1 = 0.8*ones(1,ncam(numel(ncam)));
% for i = 2:2:ncam(numel(ncam))
%     z1(i) = 3*0.8; 
% end
[vpz_bk_pv1m, vpx_bk_pv1m, vsh_bk_pv1m, vsv_bk_pv1m] = backus (vel_1m,den,ncam,z1);
[vpz_bk_pv5k, vpx_bk_pv5k, vsh_bk_pv5k, vsv_bk_pv5k] = backus (vel_5k,den,ncam,z1);


%% FIGURAS

% MODELO ABS
figure(1)
subplot(1,2,1)
hold on
plot([vpz_5k_ab(1:5);vpz_5k_ab(7)],[ncam_ab(1:5);ncam_ab(7)],'-o','LineWidth',2)
plot([vpz_1m_ab(1:5);vpz_1m_ab(7)],[ncam_ab(1:5);ncam_ab(7)],'-o','LineWidth',2)
plot(vsv_5k_ab,ncam_ab,'-o','LineWidth',2)
plot(vsv_1m_ab,ncam_ab,'-o','LineWidth',2)
plot(vsh_5k_ab,ncam_ab,'-o','LineWidth',2)
plot(vsh_1m_ab,ncam_ab,'-o','LineWidth',2)
plot(vpz_bk_pv5k,ncam,'--','LineWidth',2)
plot(vsv_bk_pv5k,ncam,'--','LineWidth',2)
plot(vsh_bk_pv5k,ncam,'--','LineWidth',2)
set(gca,'YDir','reverse')
set(gca,'FontSize',16)
title('PVC and Epoxy resin')
xlabel('Velocity [m/s]')
ylabel('Number of Layers')
set(gca,'YTick',ncam_ab)
xlim([500 3000])
ylim([3 67])
box on; grid on;

subplot(1,2,2)
hold on
plot(vpz_5k_ac(2:8),ncam_ac(2:8),'-o','LineWidth',2)
plot(vpz_1m_ac(2:8),ncam_ac(2:8),'-o','LineWidth',2)
plot(vsv_5k_ac,ncam_ac,'-o','LineWidth',2)
plot(vsv_1m_ac,ncam_ac,'-o','LineWidth',2)
plot(vsh_5k_ac,ncam_ac,'-o','LineWidth',2)
plot(vsh_1m_ac,ncam_ac,'-o','LineWidth',2)
leg1 = legend('V_{PZ} 500 kHz','V_{PZ} 1 MHz','V_{SV} 500 kHz','V_{SV} 1 MHz',...
    'V_{SH} 500 kHz','V_{SH} 1 MHz')
set(leg1,'Position',[0.397 0.431 0.262 0.151],'NumColumns',2);
set(gca,'YDir','reverse')
plot(vpz_bk_ac5k,ncam,'--','LineWidth',2)
plot(vsv_bk_ac5k,ncam,'--','LineWidth',2)
plot(vsh_bk_ac5k,ncam,'--','LineWidth',2)
set(gca,'FontSize',16)
title('Acrylic and Epoxy Resin + Fine Sand')
xlabel('Velocity [m/s]')
set(gca,'YTick',ncam_ac)
xlim([500 3000])
ylim([3 67])
box on; grid on;

set(gcf,'Position',[50 50 1500 1000])