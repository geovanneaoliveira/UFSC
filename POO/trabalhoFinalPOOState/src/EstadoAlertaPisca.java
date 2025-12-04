public class EstadoAlertaPisca implements SemaforoState {

    @Override
    public void executar(SemaforoController ctx) {

        if (!ctx.isAlerta()) return;

        // Acesos
        ctx.aplicarLuz(LightState.AMARELO);
        ctx.aplicarLuzOposto(LightState.AMARELO);  // <<< NOVO
        ctx.esperar(500);

        if (!ctx.isAlerta()) return;

        // Apagados
        ctx.aplicarLuz(LightState.OFF);
        ctx.aplicarLuzOposto(LightState.OFF);      // <<< NOVO
        ctx.esperar(500);
    }
}
