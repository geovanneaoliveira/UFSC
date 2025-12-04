public class ModoNoturno implements ModoOperacao {

    @Override
    public int getTempoVerde() {
        return 2000; // 2s
    }

    @Override
    public int getTempoAmarelo() {
        return 1000; // 1s
    }

    @Override
    public String getNome() {
        return "Noturno";
    }
}
