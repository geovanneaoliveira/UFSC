clear all;
clc;
close all;

%% PARÂMETROS
n_amostras = 9;
freq_Hz = [0.1, 1, 2, 3, 5, 10, 20, 50, 100]

Entradas  = cell(1, n_amostras);
Respostas = cell(1, n_amostras);
freq_amostragem = 0;

%% PROCESSAMENTO DE CADA ARQUIVO
for i = 1:n_amostras

    f = freq_Hz(i);

    f_str = strrep(num2str(f), '.', '_');
    nome  = sprintf('resposta_senoide_f0_%sHz.mat', f_str);

    fprintf('Carregando: %s\n', nome);
    load(nome);

    u  = x;
    y  = y;

    freq_amostragem = fs;
    idx_rp = round(0.2 * length(y));

    u_rp = u(idx_rp:end);
    y_rp = y(idx_rp:end);

    %% CENTRALIZAR EM ZERO
    offset_u = (max(u_rp) + min(u_rp)) / 2;
    offset_y = (max(y_rp) + min(y_rp)) / 2;

    u_cent = u - offset_u;
    y_cent = y - offset_y;

    %% ARMAZENA
    Entradas{i}  = u_cent;
    Respostas{i} = y_cent;
end

%% MONTA ESTRUTURA IGUAL À ATIVIDADE 1
Data_out.frequencia_amostragem = freq_amostragem;
Data_out.frequencia_senoides   = freq_Hz;
Data_out.Entradas              = Entradas;
Data_out.Respostas             = Respostas;

%% SALVA ARQUIVO UNIFICADO 
Data = Data_out;
save('Sistema_pratico.mat', 'Data');

fprintf('\nArquivo salvo: Sistema_pratico.mat\n');
fprintf('Frequências (Hz): ');
fprintf('%.4f  ', freq_Hz);
fprintf('\n');