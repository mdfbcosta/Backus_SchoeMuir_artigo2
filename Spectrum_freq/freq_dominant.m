function [f,aux2,f_max,max_aux] = freq_dominant(A,dt)
%  created by: José Jésus
%  adapt by: M. Danilo
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
set(gcf,'Position',[50 50 1050 750]);

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

DFT_Aw = fft(A_w); %Evaluating DFT
df = 1/(length(A_w)*dt*1e-6); %Evaluating delta-f
f = (0:df:df*length(A_w)-df); %Creating frequency variable to plot spectrum
%F_Ny = 1/(2*dt);    

string = strcat({'Amplitude Spectrum - '},inputname(1));

f = f/1000;      %conveting Hz to KHz

% Finding the dominant frequency
aux = abs(DFT_Aw);
aux_ascen = sort(aux);
max_aux = max(aux);
ind_max_aux = find(abs(aux-max_aux) < 0.001);
ind_max_freq = min(ind_max_aux);
if ind_max_freq == 1
     max_aux = aux_ascen(length(aux_ascen)-1);
     ind_max_aux = find(abs(aux-max_aux) < 0.001);
     ind_max_freq = min(ind_max_aux);
end
f_max = f(ind_max_freq);

% Normalizando pelo valor máximo
DFT_Aw = DFT_Aw./max(DFT_Aw);
aux2 = abs(DFT_Aw);

end
