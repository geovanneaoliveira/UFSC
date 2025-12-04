public class ModoDiurno implements ModoOperacao {

    @Override
    public int getTempoVerde() {
        return 4000; // 4s
    }

    @Override
    public int getTempoAmarelo() {
        return 2000; // 2s
    }

    @Override
    public String getNome() {
        return "Diurno";
    }
}
