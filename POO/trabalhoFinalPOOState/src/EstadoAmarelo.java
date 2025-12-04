public class EstadoAmarelo implements SemaforoState {

    @Override
    public void executar(SemaforoController ctx) {
        ctx.aplicarLuz(LightState.AMARELO);
        ctx.esperar(ctx.getModo().getTempoAmarelo());

        ctx.setEstado(new EstadoVermelho());
    }
}
