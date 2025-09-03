% DAQ - Leitura e escrita com Matlab
% Barramento de entrada analógica
% Nome do dispositivo
dev = daqlist("ni").DeviceID;
% Configuração do barramento
% Criação do objeto
dqi = daq("ni"); %criação do objeto
% Frequência de amostragem
dqi.Rate = 1000; %frequência de amostragem
% Adiciona um único canal
inCh = addinput(dqi,dev,0,"Voltage"); %adiciona a entrada AI0 no objeto dqi
% Adiciona múltiplos canais
inCh = addinput(dqi,dev,0:2,"Voltage"); %adiciona a entradas AI0, AI1 e AI2 no objeto dqi
% Modo RSE
inCh.TerminalConfig = "SingleEnded"; %configura o barramento no modo RSE
% Modo Diferencial
inCh.TerminalConfig = "Differential"; %configura o barramento no modo Diferencial
% Leitura sob demanda
% Uma única amostra
vin = read(dqi,1,"OutputFormat","Matrix");
% Número determinado de amostras
[vin,t] = read(dqi,100,"OutputFormat","Matrix"); %serão adquiridas 100 amostras
% Limitado por tempo
[vin,t] = read(dqi,seconds(0.05),"OutputFormat","Matrix"); %serão adquiridas amostras
% durante 50 ms
% Leitura em background
% Cadastro da função de interrupção
dqi.ScansAvailableFcn = @(src,evt) plot_aquisicao(src, evt);
% Número de amostras para ocorrer a interrupção
dqi.ScansAvailableFcnCount = 1000; %nesse caso, teremos uma interrupção a cada 1000 amostras adquiridas
% Inicia a leitura de forma contínua
start(dqi,"continuous");
% Inicia a leitura por tempo determinado
start(dqi, "Duration", seconds(10)) % a leitura ficará ativa por 10 segundos
% Inicia a leitura até atingir um número de amostras
start(dqi, "NumScans", 100) % a leitura ficará ativa até obter 100 amostras

% pause?
% FUNCAO INTERRUPCAO

% Liberação do hardware
stop(dqi) %encerra o processo de leitura
clear("dqi") %libera os recursos de hardware para outra aplicação

function plot_aquisicao(src, ~)
    [vin, t] = read(src, src.ScansAvailableFcnCount, "OutputFormat", "Matrix");
    plot(t, vin);
end