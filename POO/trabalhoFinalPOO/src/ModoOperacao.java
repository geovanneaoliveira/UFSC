public interface ModoOperacao {
    // tempos em milissegundos
    long getTempoVerde();
    long getTempoAmarelo();
    long getTempoVermelho(); // útil para modos que querem controlar vermelho diretamente
    String getNome();
}
