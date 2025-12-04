public class EstadoVermelho implements SemaforoState {

    @Override
    public void executar(SemaforoController ctx) {
        ctx.aplicarLuz(LightState.VERMELHO);

        // atraso de segurança
        ctx.esperar(1000);

        // troca o controle para o semáforo oposto
        ctx.trocarControle();

        // quando volta ao ciclo, entra no verde novamente
        ctx.setEstado(new EstadoVerde());
    }
}
