public class ModoNoturno implements ModoOperacao {

    @Override
    public long getTempoVerde() {
        return 4000; // 4s (menos fluxo)
    }

    @Override
    public long getTempoAmarelo() {
        return 1500; // 1.5s
    }

    @Override
    public long getTempoVermelho() {
        return 4000;
    }

    @Override
    public String getNome() {
        return "Noturno";
    }
}
