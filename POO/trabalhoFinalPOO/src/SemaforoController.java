import javax.swing.*;

public class SemaforoController implements Runnable {
    private final SemaforoPanel painel;
    private final SemaforoPanel painelOposto;
    private volatile boolean running = true;
    private volatile boolean paused = false;
    private volatile boolean alerta = false;   // <<< NOVO
    private ModoOperacao modo;

    public SemaforoController(SemaforoPanel painel, SemaforoPanel painelOposto, ModoOperacao modo) {
        this.painel = painel;
        this.painelOposto = painelOposto;
        this.modo = modo;
    }

    public void setModo(ModoOperacao modo) {
        this.modo = modo;
    }

    public void setAlerta(boolean ativado) {   // <<< NOVO
        this.alerta = ativado;
    }

    public void stop() {
        running = false;
    }

    public void pauseToggle() {
        paused = !paused;
    }

    private void sleepAccurate(long ms) {
        long end = System.currentTimeMillis() + ms;
        while (running && System.currentTimeMillis() < end) {
            if (paused) {
                try { Thread.sleep(100); } catch (Exception ignored) {}
                continue;
            }
            try { Thread.sleep(50); } catch (Exception ignored) {}
        }
    }

    @Override
    public void run() {
        setStateSafe(painel, LightState.VERDE);
        setStateSafe(painelOposto, LightState.VERMELHO);

        while (running) {

            // ---------------------------------------------------------
            //        MODO ALERTA — pisca-pisca amarelo
            // ---------------------------------------------------------
            if (alerta) {
                // aceso
                setStateSafe(painel, LightState.AMARELO);
                setStateSafe(painelOposto, LightState.AMARELO);
                sleepAccurate(500);

                // apagado
                setStateSafe(painel, LightState.OFF);
                setStateSafe(painelOposto, LightState.OFF);
                sleepAccurate(500);
                continue; // mantém no alerta
            }

            // ---------------------------------------------------------
            //        CICLO NORMAL
            // ---------------------------------------------------------

            // Verde
            setStateSafe(painel, LightState.VERDE);
            setStateSafe(painelOposto, LightState.VERMELHO);
            sleepAccurate(modo.getTempoVerde());

            // Amarelo
            setStateSafe(painel, LightState.AMARELO);
            sleepAccurate(modo.getTempoAmarelo());

            // Vermelho
            setStateSafe(painel, LightState.VERMELHO);
            sleepAccurate(1000); // atraso antes de abrir o outro

            // Verde do oposto
            setStateSafe(painelOposto, LightState.VERDE);
            sleepAccurate(modo.getTempoVerde());

            // Amarelo do oposto
            setStateSafe(painelOposto, LightState.AMARELO);
            sleepAccurate(modo.getTempoAmarelo());

            // Vermelho
            setStateSafe(painelOposto, LightState.VERMELHO);
            sleepAccurate(1000); // atraso antes de abrir o atual
        }
    }

    private void setStateSafe(SemaforoPanel p, LightState s) {
        SwingUtilities.invokeLater(() -> p.setState(s));
    }
}
