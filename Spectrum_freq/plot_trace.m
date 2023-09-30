function trace = plot_trace(trace,dt,varargin)
%  Objective: function to plot trace with the option of filtering with band_pass function. 
%
%   Inputs: 1) ultrassonic trace
%           2) delta-t (in microseconds)
%           3) Corner frequencies for the function band_pass
%
% Created by José Jésus
%  Oct 26 2017

t = (0.0:dt:dt*(length(trace)-1));
antes = trace;
t1 = linspace(0,dt*length(antes),length(antes))';

if ~isempty(varargin)
    freq = varargin{1};
    %aplying band pass filter to traces:
    trace = band_pass(trace,dt,freq);
end

string = inputname(1);
if isempty(string)
    string = 'Input';
end
% figure()
% plot(t1,antes,'r')
% hold on
% plot(t,trace,'LineWidth',2)
% title('Limits of Pass Band Filter')
% legend('Full Waveform','Pass band filter')
% ylabel('Amplitude [a.u.]')
% xlabel('Time [\mu s]')
% grid on
% %legend(string)

fileID1 = fopen('PBF_T500kHz.txt','w');
fprintf(fileID1,'%12.8f\n',trace');
fclose(fileID1);

end