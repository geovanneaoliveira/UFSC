import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;

public class MainFrame extends JFrame {
    private final SemaforoPanel semafaroNorte;
    private final SemaforoPanel semafaroLeste;
    private final JButton btnModo;
    private final JButton btnAlerta; // <<< NOVO
    private final JLabel lblStatus;

    private boolean alertaAtivo = false; // <<< NOVO

    private ModoOperacao modoDiurno = new ModoDiurno();
    private ModoOperacao modoNoturno = new ModoNoturno();
    private ModoOperacao modoAtual;

    private SemaforoController controller1;
    private Thread threadController;

    public MainFrame() {
        super("Semáforo Inteligente - Trabalho Final");

        modoAtual = modoDiurno;

        semafaroNorte = new SemaforoPanel("Norte-Sul");
        semafaroLeste = new SemaforoPanel("Leste-Oeste");

        btnModo = new JButton("Alternar modo");
        btnAlerta = new JButton("Modo Alerta"); // <<< NOVO
        lblStatus = new JLabel("Modo: " + modoAtual.getNome());

        controller1 = new SemaforoController(semafaroNorte, semafaroLeste, modoAtual);
        threadController = new Thread(controller1, "Controller-1");
        threadController.start();

        setupLayout();
        attachListeners();

        pack();
        setLocationRelativeTo(null);
        setVisible(true);
    }

    private void setupLayout() {
        JPanel semaforosPanel = new JPanel();
        semaforosPanel.setLayout(new FlowLayout(FlowLayout.CENTER, 40, 20));
        semaforosPanel.add(semafaroNorte);
        semaforosPanel.add(semafaroLeste);

        JPanel controls = new JPanel();
        controls.setLayout(new FlowLayout());
        controls.add(btnModo);
        controls.add(btnAlerta); // <<< NOVO

        JPanel bottom = new JPanel(new BorderLayout());
        bottom.add(controls, BorderLayout.CENTER);
        bottom.add(lblStatus, BorderLayout.SOUTH);

        getContentPane().setLayout(new BorderLayout());
        getContentPane().add(semaforosPanel, BorderLayout.CENTER);
        getContentPane().add(bottom, BorderLayout.SOUTH);
    }

    private void attachListeners() {

        btnModo.addActionListener((ActionEvent e) -> {
            if (alertaAtivo) {
                JOptionPane.showMessageDialog(this,
                        "Desative o modo ALERTA para trocar o modo.");
                return;
            }

            modoAtual = (modoAtual == modoDiurno ? modoNoturno : modoDiurno);
            controller1.setModo(modoAtual);

            btnModo.setText("Alternar modo");
            lblStatus.setText("Modo: " + modoAtual.getNome());

            JOptionPane.showMessageDialog(this,
                    "Modo alterado para: " + modoAtual.getNome());
        });

        // -------- MODO ALERTA --------
        btnAlerta.addActionListener((ActionEvent e) -> {
            alertaAtivo = !alertaAtivo;
            controller1.setAlerta(alertaAtivo);

            if (alertaAtivo) {
                lblStatus.setText("Modo: ALERTA");
                btnAlerta.setText("Desativar Alerta");
            } else {
                lblStatus.setText("Modo: " + modoAtual.getNome());
                btnAlerta.setText("Modo Alerta");
            }
        });
    }

    @Override
    public void dispose() {
        controller1.stop();
        super.dispose();
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(MainFrame::new);
    }
}
