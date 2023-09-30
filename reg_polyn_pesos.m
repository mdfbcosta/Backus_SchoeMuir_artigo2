function [Y_recon,X_domin,rmse] = reg_polyn_pesos (X,Y,X_ref,Y_ref)
% Dados de exemplo
%X = [1, 2, 3, 4, 5];
%Y = [2, 3, 4, 4, 5];

% Dados de referência (outro conjunto de dados)
%X_ref = [1.2, 2.3, 3.1, 3.5, 5.0];
%Y_ref = [2.1, 3.2, 4.1, 4.5, 5.0];

% Calcula as distâncias entre os pontos de dados originais e os pontos de referência
distancias = sqrt((X - X_ref).^2 + (Y - Y_ref).^2);

% Calcule os pesos com base nas distâncias (quanto mais próximo, maior o peso)
%pesos = 1 ./ distancias;
% Calcule os pesos com base nas distâncias (quanto mais próximo, maior o peso)
pesos = 1 - (distancias - min(distancias)) / (max(distancias) - min(distancias));

% Grau do polinômio (por exemplo, 2 para uma regressão quadrática)
grau_polinomio = 1;

% Multiplica os pesos pelos dados originais para criar "dados ponderados"
X_ponderados = X .* pesos;
Y_ponderados = Y .* pesos;

% Ajuste da regressão polinomial sem pesos nos dados ponderados
coeficientes = polyfit(X_ponderados, Y_ponderados, grau_polinomio);

% Gere uma curva de ajuste usando os coeficientes
X_fit = min(X):0.01:max(X); % Valores X para a curva de ajuste
Y_fit = polyval(coeficientes, X_fit);%/30.7;

% Calcule o erro residual (diferença entre os dados ajustados e os dados originais)
erro_residual = Y - polyval(coeficientes, X);

% Calcule o erro médio quadrático (RMSE)
rmse = sqrt(mean(erro_residual.^2));

% Exiba o RMSE
%fprintf('Erro Médio Quadrático (RMSE): %.4f\n', rmse);

% % Plote os dados e a curva de ajuste
% figure(100)
% hold on;
% scatter(Y, X, 'b', 'filled'); % Scatter plot dos dados
% plot(Y_fit, X_fit, 'g', 'LineWidth', 2); % Curva de ajuste
% plot(Y_ref,X_ref,'*-k')
% plot(Y_ponderados,X_ponderados,'m')
% set(gca,'FontSize',16)
% set(gca,'YDir','reverse')
% xlabel('Variável Independente');
% ylabel('Variável Dependente');
% title('Regressão Polinomial com Pesos');
% legend('Dados', 'Regressão Polinomial');
% grid on;
% 
% % Exiba o erro residual
% figure(101);
% plot(erro_residual, X, 'g', 'LineWidth', 2);
% ylabel('Variável Independente');
% xlabel('Erro Residual');
% xlim([-0.2 0.6])
% set(gca,'YDir','reverse')
% title('Erro Residual da Regressão Polinomial');
% grid on;

% Valores independentes para a construção do dado representado pela curva
X_domin = [13, 29, 45, 61, 77, 93, 117, 133, 149];

% Calcule os valores dependentes correspondentes usando o polinômio ajustado
Y_recon = polyval(coeficientes, X_domin);
