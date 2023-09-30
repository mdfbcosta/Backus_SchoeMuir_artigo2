function [Z] = reg_linear (X,Y)
% Dados de exemplo
%X = [1, 2, 3, 4, 5];
%Y = [2, 3, 4, 4, 5];

% Calcula a média de X e Y
meanX = mean(X);
meanY = mean(Y);

% Calcula os coeficientes da regressão linear
numerator = sum((X - meanX) .* (Y - meanY));
denominator = sum((X - meanX) .^ 2);
slope = numerator / denominator;
intercept = meanY - slope * meanX;

Z = slope * X + intercept; % Calcula os valores previstos

% Imprime os coeficientes
fprintf('Coeficiente de Inclinação (Slope): %.2f\n', slope);
fprintf('Interceptação (Intercept): %.2f\n', intercept);

% Plota os dados e a linha de regressão
figure(100)
hold on;
scatter(Y, X, 'b', 'filled'); % Scatter plot dos dados
plot(Z, X, 'r', 'LineWidth', 2); % Linha de regressão
set(gca,'FontSize',16)
set(gca,'YDir','reverse')
%xlim([-0.2 0.6])
%ylim([0 180])
xlabel('Variável Independente');
ylabel('Variável Dependente');
title('Regressão Linear');
legend('Dados', 'Regressão Linear');
grid on;