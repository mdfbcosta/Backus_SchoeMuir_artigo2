%Function fourierwindow
%   Easily plot the amplitude spectrum of a window
%   of a seismic trace. The window is chosen manually
%   by the user using the mouse.
%
%   It has as inputs the row vector 'A' (trace), and the delta-t
%   dt (in microseconds).
%   Output: matrix Nx2, where the first column is the vector frequency 'f'
%   and the second column is the DFT of the time series. N is the size of the
%   input time series A.
%    
%    Syntax:
%    X = fourierwindow(A,dt)
%    output: X = [f; fftA]    
%
%   Obs: the function initially plots the time series for the user
%   to visualize and select the beginning and end of the window.
%   Once in the plot, left-click on the beginning point, if correct press
%   'enter' to save the point, otherwise press 'delete' or 'backspace'
%   to chose again the point. More information read 'help getpts'.
%
%   Obs2: it is important to choose beginning and end points at the same
%   value of amplitude to avoid Gibbs' effect.

function [f,absAw] = fourierwindow(A,dt,name,ind)
%  created by: José Jésus
%
%  version 0.0
%  date: 04-07-2017
%  modified: 09/09/2017 - inserted factor to change frequency resolution in line 50

t = (0.0:dt:(length(A)-1)*dt); %time vector to plot trace

%ploting trace
fig = figure();
plot(t,A)
xlabel('Time [\mus]')
ylabel('Amplitude [a.u.]')
title('Select begin and end of waveform')
grid on
set(gcf,'Position',[50 50 2050 750]);

%pause;
[xi yi] = getpts(fig); %picking the waveform
[xf yf] = getpts(fig); %picking the waveform

close(fig)

A_w = A((fix(xi/dt)+1):(fix(xf/dt)+1));  %cuting the waveform

c = zeros(1,8*length(A)-length(A_w));%to change frequency resolution is only needed to change
%factor multiplying length(A).

for i=1:length(A_w)  %evitar efeito gibbs
    A_w(i) = A_w(i) -yf;
end

A_w = [A_w' c]; %filling the cutted waveform with zeros
                %to gain a better resolution in the
                %frequency domain

t = (0.0:dt:(length(A_w)-1)*dt); %time vector to plot trace

% string = strcat({'Windowed waveform - '},inputname(1));
% %ploting cutted waveform in time domain:
% figure()
% plot(t,A_w)
% xlabel('Time [\mus]')
% ylabel('Amplitude [a.u.]')
% grid on
% title(string)

DFT_Aw = fft(A_w); %Evaluating DFT
df = 1/(length(A_w)*dt*1e-6); %Evaluating delta-f
f = (0:df:df*length(A_w)-df); %Creating frequency variable to plot spectrum
%F_Ny = 1/(2*dt);    

string = strcat({'Amplitude Spectrum - '},inputname(1));

f = f/1000;      %conveting Hz to KHz

%ploting amplitude spectrum

% Normalizando pelo valor máximo
DFT_Aw = DFT_Aw./max(DFT_Aw);

figure (100)

if ind == 100
    title('Frequency spectrum for 100 kHz')
    subplot(3,1,1)
elseif ind == 500
    title('Frequency spectrum for 500 kHz')
    subplot(3,1,2)
elseif ind == 1000
    subplot(3,1,3)
    title('Frequency spectrum for 1 MHz')
end

hold on
absAw = abs(DFT_Aw);
plot(f,absAw,'LineWidth',2);
xlabel('Frequency [KHz]')
ylabel('Amplitude [a.u.]')
grid on
set(gca, 'Fontsize',17);
legend(name)
set(legend,...
   'Position',[0.502790477752442 0.725550447579971 0.493150672547894 0.193548381603258]);
axis([min(f) 1.6e+3 min(abs(DFT_Aw)) max(abs(DFT_Aw))*1.1])

y = [f' ,DFT_Aw']; %assigning outputs.

end
