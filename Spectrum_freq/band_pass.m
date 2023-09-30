function filtered_trace = band_pass(traces,dt,freq)
%  Função para filtrar dados ultrassônicos com passa-banda.
%
%  Inputs: 1) seismic trace na forma de vetor coluna, ou matriz com n vetores
%          vetores colunas.
%          2) delta-t em microsegundos.
%          3) vetor freq contendo os quatro valores de corner frequencies (em kHz)
%          freq = [f1,f2,f3,f4]. Obedecendo: 0<=f1, f1<f2, f2<f3 e f3<f4.
%
%   Outputs: dados filtrados.
%
%   As frequências f2 e f3 definem a banda, enquanto que os outros dois
%   valores ajudam a evitar efeito Gibs. Este filtro utiliza uma janela
%   trapezoidal, os quatro valores de freq são as corners do trapézio.
%
%   Ex.: seismic = band_pass(trace,dt,[0,40,920,960]);
%   Obs1: Os valores do vetor freq dependem da frequencia dominante do
%   transdutor. Os valores do exemplo acima funcionaram bem para o
%   trandustor de onda S de 500 kHz, mas podem não servir para um
%   trandustor de 1 MHz.
%
%   Obs2: esta função é uma adaptação da função s_filter contida no SeisLab
%   para dados ultrassônicos. Por isso ela utiliza algumas funções contidas
%   no pacote SeisLab.
%
%  by José Jésus
%  date: 25/10/2017
%  version: 1.0
%

if length(freq) ~= 4
    error('Wrong number of corner frequencies')
end

%utilizando a function s_convert para deixar os dados na forma utilizada pelo
%SeisLab:
s_seismic = s_convert(traces,0.0,dt*1e-3);

freq = 1000*freq; %Convertendo os valores de kHz para Hz.

s_seismic = s_filter(s_seismic,{'ormsby',freq});

filtered_trace = s_seismic.traces;


end