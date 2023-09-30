close all
clear all
clc

% Exemplo de como normalizar um gráfico

x = linspace(-5,5,100);
f1 = cos(x+1);
f2 = 8*cos(x+2);
f3 = 16*cos(x+3);
f4 = 32*cos(x+4);

normaf1 = 1; % max(f1);
normaf2 = 1; % max(f2);
normaf3 = 1; % max(f3);
normaf4 = 1; % max(f4);

figure(1)
hold on
plot(x,f1./normaf1)
plot(x,f2./normaf2)
plot(x,f3./normaf3)
plot(x,f4./normaf4)
xlabel('Domínio - x')
ylabel('Imagem - f(x)')
