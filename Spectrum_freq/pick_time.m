% Objetive: discrete fourier tranform a sequence and plot its
% amplitude spectrum having as input de data vector and the delta-t.
%
% version: 1.1  Feb-17_2017
% modified: 09/09/2017 : using inputname to get name of the input on plot.
%
function [at_P] = pick_time(A,t,i,name_model)

    %figure('Name',strcat('Amplitude Spectrum','-',inputname(1)))
    plot(t,A,'LineWidth',2);
    hold on
    grid on
    box off
    set(gca, 'Fontsize',16);
    xlabel('time [s]')
    ylabel('Amplitude')
    title(strcat('Sample ',name_model{i}))
    axis([min(t) max(t) min(A) max(A)])  % for 500MHz
    %axis([min(f) 0.6e+3 min(abs(DFT_A)) max(abs(DFT_A)*5.5)])  % for 1MkHz
    
    set(gcf,'Position',[50 50 1400 500]);
    [at_P y] = ginput(2);
    close
    clearvars y