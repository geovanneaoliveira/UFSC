% Barramento de saída analógica
% Nome do dispositivo
dev = daqlist("ni").DeviceID;
% Configuração do barramento
% Criação do objeto
dqo = daq("ni"); %criação do objeto
% Frequência de escrita
dqo.Rate = 500; %frequência de escrita
% Adiciona um único canal
outCh = addoutput(dqo,dev,0,"Voltage"); %adiciona a saída AO0 no objeto dqo
% Adiciona múltiplos canais
outCh = addoutput(dqo,dev,0:1,"Voltage"); %adiciona as saídas AO0 e AI1 no objeto dqo
% Escrita sob demanda
% Uma única amostra em um único canal
write(dqo,3.5); %escreve 3.5V na única saída analógica
% Uma única amostra por canal
write(dqo,[3.5 1.0]); %escreve 3.5V na saída AO0 e 1.0V na saída AO1
% Escrita em background
% Geração das amostras
theta = linspace(0,10*pi,501); %gera o argumento para 10 períodos de uma senóide, com 501 amostras
vout = 3*sin(theta); %vetor com as amostras que devem ser carregadas no buffer de saída
vout(501) = []; %remove a última amostra, pois deve-se iniciar novamente na posição 501
% Upload (via USB) das amostras para o buffer de saída do DAQ
preload(dqo,vout);
% Inicia a escrita de forma repetida
start(dqo,"repeatoutput");
% Liberação do hardware
stop(dqo) %encerra o processo de leitura
clear("dqo") %libera os recursos de hardware para outra aplicação
% Declaração da função de interrupção

function plot_aquisicao(src, ~)
    [vin, t] = read(src, src.ScansAvailableFcnCount, "OutputFormat", "Matrix");
    plot(t, vin);
end