%% ETAPA 2 (Ensaio)

pkg load instrument-control;

clc;

% Lista portas disponiveis
portas = serialportlist();

fprintf('Portas disponiveis:\n');
for k = 1:numel(portas)
  fprintf('%d) %s\n', k, portas{k});
end

fprintf('\n');
p = input('Porta desejada: ');
fprintf('\n');

s = serial(portas{p});

% limpa buffers de transmissao e recepcao
srl_flush(s);
pause(1);

% Envia comando para inicial o ensaio
init_command = uint8([0, 1]);
fwrite(s, init_command, 'uint8');

% Espera ate que o primeiro resultado esteja disponivel
while(get(s,'BytesAvailable')<2); end;

% Le os resultados do ensaio (saida do sistema)
yu = zeros(N,1);
for k = 1:N
    rx_buffer = uint8(fread(s,2))';
    sample = typecast(rx_buffer(1:2),'uint16');

    yu(k) = sample;
end

fclose(s);

% Conversao do valor do ADC para amplitude em volts da saida do sistema
y = yu*5/1023;

% Apresenta resultados
f1 = figure('units','centimeters', 'position', [2 3 15 9]);
a1 = axes(); hold(a1,'on'); box(a1,'on'); grid(a1,'on');

plot((0:N-1)/fs, x,'k');
plot((0:N-1)/fs, y);

xlabel('tempo ($s$)','fontsize',11,'interpreter','latex');
ylabel('Amplitude ($V$)','fontsize',11,'interpreter','latex');
legend({'Entrada', 'Sa\''ida'});%, 'Location','best','Interpreter','latex', 'FontSize', 10);

ylim([0, 1.1*max(max(x),max(y))]);


save(['resposta_senoide_f0_',strrep(num2str(f0),'.','_'),'Hz.mat'], 'x', 'y', 'f0', 'fs', '-mat7-binary' );
