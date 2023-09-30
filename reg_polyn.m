%function [Y_fit,X_fit,rmse] = reg_polyn (X,Y)
function [Y_recon,X_domin,rmse] = reg_polyn (X,Y,n)
% Dados de exemplo
%X = [1, 2, 3, 4, 5];
%Y = [2, 3, 4, 4, 5];

% Grau do polinômio (por exemplo, 2 para uma regressão quadrática)
grau_polinomio = n;

% Ajuste da regressão polinomial
coeficientes = polyfit(X, Y, grau_polinomio);

% Gere uma curva de ajuste usando os coeficientes
X_fit = min(X):0.01:max(X); % Valores X para a curva de ajuste
Y_fit = polyval(coeficientes, X_fit);

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
% plot(Y_fit,X_fit, 'r', 'LineWidth', 2); % Curva de ajuste
% set(gca,'FontSize',16)
% set(gca,'YDir','reverse')
% xlabel('Variável Independente');
% ylabel('Variável Dependente');
% title('Regressão Polinomial');
% legend('Dados', 'Regressão Polinomial');
% grid on;

% % Exiba o erro residual
% figure(101);
% plot(erro_residual, X, 'r', 'LineWidth', 2);
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

% % Plote os dados e a curva de ajuste
% figure(102)
% hold on;
% plot(Y_recon,X_domin, 'r', 'LineWidth', 2); % Curva de ajuste
% set(gca,'FontSize',16)
% set(gca,'YDir','reverse')
% xlabel('Variável Independente');
% ylabel('Variável Dependente');
% title('Regressão Polinomial');
% legend('Dados', 'Regressão Polinomial');
% grid on;