public class ModoDiurno implements ModoOperacao {

    @Override
    public long getTempoVerde() {
        return 8000; // 8s
    }

    @Override
    public long getTempoAmarelo() {
        return 2000; // 2s
    }

    @Override
    public long getTempoVermelho() {
        // vermelho equivalente ao verde do semáforo oposto
        return 8000;
    }

    @Override
    public String getNome() {
        return "Diurno";
    }
}
