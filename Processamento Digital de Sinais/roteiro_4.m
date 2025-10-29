clear
clc
close all

dev = daqlist("ni").DeviceID

dqi = daq("ni"); %criação do objeto

inCh = addinput(dqi,dev,0,"Voltage"); %adiciona a entrada AI0 no objeto dqi

dqi.Rate = 1000; %frequência de amostragem

inCh.TerminalConfig = "SingleEnded"; %configura o barramento no modo RSE

dqd = daq("ni"); %criação do objeto

dqd.Rate = 500; %frequência de escrita

outCh = addoutput(dqd,dev,"port0/line1","Digital");


while 1
     
vin = read(dqi,1,"OutputFormat","Matrix")

 
 if(vin>2.5)
     write(dqd,false);
 end
 if(vin<2.5)
     write(dqd,true);
 end 
 
 pause(1);
 
 end 