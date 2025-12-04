import javax.swing.*;

public class SemaforoController implements Runnable {

    private SemaforoState estadoAtual;
    private final SemaforoPanel painel;
    private final SemaforoPanel painelOposto;
    private ModoOperacao modo;
    private boolean alerta = false;
    private boolean running = true;

    public SemaforoController(SemaforoPanel painel, SemaforoPanel painelOposto, ModoOperacao modo) {
        this.painel = painel;
        this.painelOposto = painelOposto;
        this.modo = modo;

        this.estadoAtual = new EstadoVerde();
    }

    public void aplicarLuzOposto(LightState s) {
        SwingUtilities.invokeLater(() -> painelOposto.setState(s));
    }

    public void setModo(ModoOperacao modo) {
        this.modo = modo;
    }

    public ModoOperacao getModo() {
        return modo;
    }

    public void setAlerta(boolean ativo) {
        alerta = ativo;

        if (alerta) {
            estadoAtual = new EstadoAlertaPisca();   // força entrada no alerta
        } else {
            estadoAtual = new EstadoVermelho();      // reinicia ciclo normal
        }
    }

    public boolean isAlerta() {
        return alerta;
    }

    public void stop() {
        running = false;
    }

    public void esperar(long ms) {
        long end = System.currentTimeMillis() + ms;
        while (running && System.currentTimeMillis() < end) {
            try { Thread.sleep(50); } catch (Exception ignored) {}
        }
    }

    public void aplicarLuz(LightState s) {
        SwingUtilities.invokeLater(() -> painel.setState(s));
    }

    public void setEstado(SemaforoState novo) {
        if (!alerta) {
            estadoAtual = novo;
        }
    }


    public void trocarControle() {
        // Quando termina o vermelho, o oposto inicia o ciclo verde
        painelOposto.setState(LightState.VERDE);
        esperar(modo.getTempoVerde());

        painelOposto.setState(LightState.AMARELO);
        esperar(modo.getTempoAmarelo());

        painelOposto.setState(LightState.VERMELHO);
        esperar(1000); // atraso antes de voltar ao verde do atual
    }

    @Override
    public void run() {
        while (running) {
            estadoAtual.executar(this);
        }
    }
}
