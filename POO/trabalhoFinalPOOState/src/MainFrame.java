import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;

public class MainFrame extends JFrame {

    private final SemaforoPanel norte;
    private final SemaforoPanel leste;
    private final JButton btnModo;
    private final JButton btnAlerta;
    private final JLabel lblStatus;

    private ModoOperacao modoAtual = new ModoDiurno();
    private final SemaforoController controller;
    private final Thread th;

    private boolean alertaAtivo = false;

    public MainFrame() {
        super("Semáforo com State Pattern");

        norte = new SemaforoPanel("Norte-Sul");
        leste = new SemaforoPanel("Leste-Oeste");

        btnModo = new JButton("Alternar modo");
        btnAlerta = new JButton("Modo Alerta");
        lblStatus = new JLabel("Modo: Diurno");

        controller = new SemaforoController(norte, leste, modoAtual);
        th = new Thread(controller);
        th.start();

        setLayout(new BorderLayout());

        JPanel grid = new JPanel(new FlowLayout());
        grid.add(norte);
        grid.add(leste);

        JPanel controls = new JPanel();
        controls.add(btnModo);
        controls.add(btnAlerta);

        add(grid, BorderLayout.CENTER);
        add(controls, BorderLayout.SOUTH);
        add(lblStatus, BorderLayout.NORTH);

        attachListeners();

        pack();
        setLocationRelativeTo(null);
        setVisible(true);
    }

    private void attachListeners() {

        btnModo.addActionListener((ActionEvent e) -> {
            if (alertaAtivo) {
                JOptionPane.showMessageDialog(this,
                        "Desative o alerta para mudar o modo.");
                return;
            }

            modoAtual = (modoAtual instanceof ModoDiurno)
                    ? new ModoNoturno()
                    : new ModoDiurno();

            controller.setModo(modoAtual);

            btnModo.setText("Alternar modo");
            lblStatus.setText("Modo: " + modoAtual.getNome());
        });

        btnAlerta.addActionListener((ActionEvent e) -> {
            alertaAtivo = !alertaAtivo;
            controller.setAlerta(alertaAtivo);

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
        controller.stop();
        super.dispose();
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(MainFrame::new);
    }
}
