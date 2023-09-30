% Objetive: discrete fourier tranform a sequence and plot its
% amplitude spectrum having as input de data vector and the delta-t.
%
% version: 1.1  Feb-17_2017
% modified: 09/09/2017 : using inputname to get name of the input on plot.
%
function Y = spectrum_fourier_subplot(A,dt,j,i,name_model,ind)

n_point_interp = 8;
DFT_A = fft(A);
DFT_A = interp(DFT_A,n_point_interp);
t = (0:dt:dt*length(A)-dt);   %creating
df = 1/(length(A)*dt);        %Evaluatin delta-f
f = (0:df:df*length(A)-df);   %Creating frequency variable to plot spectrum
f = interp(f,n_point_interp);
F_Ny = 1/(2*dt);              %Max frequency due to discretization
   
DFT_A = DFT_A./max(DFT_A);

if df/1000 <= 1
    
    figure('Name',strcat('Amplitude Spectrum','-',inputname(1)))
    grid on
    box off
    plot(f,abs(DFT_A),'r','LineWidth',2);
    set(gca, 'Fontsize',14);
    xlabel('Frequency [Hz]')
    ylabel('Amplitude')
    title(strcat('Frequency spectrum for transducer of 500 kHz','-',inputname(1)))
    axis([min(f) (max(f)/2)*1.05 min(abs(DFT_A)) max(abs(DFT_A)*1.1)])
else
    f = f/1000;      %conveting Hz to KHz
    
    figure(2)
    %figure('Name',strcat('Amplitude Spectrum','-',inputname(1)))
    plot(f,abs(DFT_A),'LineWidth',2);
    hold on
    grid on
    box off
    set(gca, 'Fontsize',17);
    xlabel('Frequency [kHz]')
    ylabel('Amplitude [a.u.]')
    %title(strcat('Spectrum','-',name_model{i}))
    if ind == 1000
        title('Frequency spectrum for transducer of 1 MHz')
    elseif ind == 500
        title('Frequency spectrum for transducer of 500 kHz')
    end
    legend(name_model)
    axis([min(f) 1.6e+3 min(abs(DFT_A)) max(abs(DFT_A))])
    
    set(gcf,'Position',[50 50 1050 750]);
end
