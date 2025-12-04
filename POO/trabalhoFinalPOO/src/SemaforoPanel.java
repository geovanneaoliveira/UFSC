import javax.swing.*;
import java.awt.*;

public class SemaforoPanel extends JPanel {
    private LightState state = LightState.VERMELHO;
    private final String rotulo;

    public SemaforoPanel(String rotulo) {
        this.rotulo = rotulo;
        setPreferredSize(new Dimension(120, 260));
    }

    public synchronized void setState(LightState newState) {
        this.state = newState;
        repaint();
    }

    public synchronized LightState getState() {
        return state;
    }

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);

        g.setColor(Color.DARK_GRAY);
        g.fillRoundRect(10, 10, getWidth()-20, getHeight()-20, 20, 20);

        int cx = getWidth() / 2;
        int radius = 56;
        int spacing = 10;
        int top = 20;

        // Vermelho
        g.setColor(state == LightState.VERMELHO ? Color.RED : Color.GRAY);
        if (state == LightState.OFF) g.setColor(Color.GRAY);
        g.fillOval(cx - radius/2, top, radius, radius);

        // Amarelo
        g.setColor(state == LightState.AMARELO ? Color.YELLOW : Color.GRAY);
        if (state == LightState.OFF) g.setColor(Color.GRAY);
        g.fillOval(cx - radius/2, top + radius + spacing, radius, radius);

        // Verde
        g.setColor(state == LightState.VERDE ? Color.GREEN : Color.GRAY);
        if (state == LightState.OFF) g.setColor(Color.GRAY);
        g.fillOval(cx - radius/2, top + 2*(radius + spacing), radius, radius);

        g.setColor(Color.WHITE);
        g.drawString(rotulo, 10, getHeight()-10);
    }
}
