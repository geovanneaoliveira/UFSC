public class EstadoVerde implements SemaforoState {

    @Override
    public void executar(SemaforoController ctx) {
        ctx.aplicarLuz(LightState.VERDE);
        ctx.esperar(ctx.getModo().getTempoVerde());

        ctx.setEstado(new EstadoAmarelo());
    }
}
