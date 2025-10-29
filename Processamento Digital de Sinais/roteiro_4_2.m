clear
clc
close all

dev = daqlist("ni").DeviceID

dqi = daq("ni"); %criação do objeto

inCh = addinput(dqi,dev,0,"Voltage"); %adiciona a entrada AI0 no objeto dqi

dqi.Rate = 1000; %frequência de amostragem

inCh.TerminalConfig = "SingleEnded"; %configura o barramento no modo RSE

dqo = daq("ni"); %criação do objeto

dqo.Rate = 2000; %frequência de escrita

outCh = addoutput(dqo,dev,0,"Voltage");

theta = linspace(0,20*pi,2001)';
vout = 2*sawtooth(theta,0.5)+2;
theta(end) = [];
preload(dqo,vout);
start(dqo,"repeatoutput");




dqi.ScansAvailableFcn = @(src,evt) plot_aquisicao(src, evt);
dqi.ScansAvailableFcnCount = 2000;
start(dqi,"continuous");
start(dqi, "Duration", seconds(2))
start(dqi, "NumScans", 2000) 

pause()
stop(dqi); %encerra o processo de leitura
clear("dqi");
stop(dqo);
clear("dqo");

function plot_aquisicao(src, ~)
[vin, t] = read(src, src.ScansAvailableFcnCount, "OutputFormat", "Matrix");
plot(t, vin);
end

