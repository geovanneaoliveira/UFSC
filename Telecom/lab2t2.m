%% Roteiro 3: Curvas em Cascata BER x Eb/No (Teórico vs. Simulado) 
clear; clc; close all; 
% 1. Parâmetros Iniciais 
M = 64;                     
k = log2(M);               
numBits = 6e5;          
% Ordem da modulação (Ex: 4 para QPSK) 
% Bits por símbolo 
   % Número de bits (alto para capturar erros em SNR alta) 
EbNo_dB = 0:2:18;   
       % Vetor de valores de Eb/No em dB para a varredura 
BER_sim = zeros(length(EbNo_dB), 1); % Vetor para armazenar os resultados simulados 
SER_sim = zeros(length(EbNo_dB), 1);
fprintf('Iniciando simulação Monte Carlo para %d-PSK...\n', M); 
% 2. Loop de Simulação para cada valor de Eb/No 
for i = 1:length(EbNo_dB) 
% Geração de bits aleatórios 
bitsIn = randi([0 1], numBits, 1); 
     
    % Agrupamento de bits em símbolos e Modulação 
    simbolosIn = bit2int(bitsIn, k); 
    sinalModulado = qammod(simbolosIn, M); % Fase deslocada para QPSK 
     
    % Passagem pelo Canal AWGN 
    % A função awgn precisa da SNR. Relação: SNR = Eb/No + 10*log10(k) 
    snr = EbNo_dB(i) + 10*log10(k); 
    sinalRecebido = awgn(sinalModulado, snr, 'measured'); 
     
    % Demodulação e conversão de volta para bits 
    simbolosOut = qamdemod(sinalRecebido, M); 
    bitsOut = int2bit(simbolosOut, k); 
     
    % Cálculo empírico da Taxa de Erro de Bit (BER) 
    [~, BER_sim(i)] = biterr(bitsIn, bitsOut); 
    [~, SER_sim(i)] = symerr(simbolosIn, simbolosOut);
    fprintf('Eb/No = %2d dB | BER Simulada = %e | SER = %e\n', EbNo_dB(i), BER_sim(i), SER_sim(i)); 
end 
 
% 3. Cálculo da Curva Teórica 
% A função berawgn retorna a BER teórica para modulações específicas 
BER_teo = berawgn(EbNo_dB, 'qam', M, 'nondiff'); 
 
% 4. Plotagem em Cascata (Waterfall Curve) 
figure('Name', 'Desempenho BER', 'NumberTitle', 'off'); 
semilogy(EbNo_dB, BER_teo, 'b-', 'LineWidth', 2); % Linha contínua azul para o Teórico 
hold on; 
semilogy(EbNo_dB, BER_sim, 'ro', 'MarkerSize', 8, 'LineWidth', 1.5); % Círculos vermelhos para o Simulado 
% Formatação do Gráfico 
grid on; 
set(gca, 'YScale', 'log'); % Garante a escala logarítmica no eixo Y 
axis([min(EbNo_dB) max(EbNo_dB) 1e-5 1]); % Limites de visualização dos eixos 
legend('Teórico (Equação)', 'Simulado (Monte Carlo)', 'Location', 'southwest'); 
xlabel('E_b/N_0 (dB)'); 
ylabel('Taxa de Erro de Bit (BER)'); 
title(['Curva de Desempenho: ', num2str(M), '-QAM em Canal AWGN']);

figure;
semilogy(EbNo_dB, BER_sim,'r','LineWidth',2); hold on;
semilogy(EbNo_dB, SER_sim,'b','LineWidth',2);
grid on;
xlabel('Eb/N0 (dB)');
ylabel('Erro');
title('64-QAM: BER vs SER');
legend('BER','SER');

% Relação SER/BER em alta SNR
idx_high = find(EbNo_dB >= 14);

ratio = mean(SER_sim(idx_high) ./ BER_sim(idx_high));

fprintf('\n Relação SER/BER\n');
fprintf('SER = %.3f * BER\n', ratio);
fprintf('Esperado teórico: %.0f\n', k);