package com.shop.view;

import javax.swing.BorderFactory;
import javax.swing.JPanel;
import java.awt.CardLayout;
import java.util.HashMap;

public class Screens extends JPanel {

    private HashMap<String, JPanel> screens = new HashMap<>();
    private CardLayout cardLayout = new CardLayout();

    public Screens() {
        setBorder(BorderFactory.createEtchedBorder());
        setLayout(cardLayout);
    }

    public void addScreen(JPanel screen, String title) {
        screens.put(title, screen);
        add(screen, title);
    }

    public void changeScreen(String screen) {
        cardLayout.show(this, screen);
    }

    public void removeScreen(String title) {
        remove(screens.get(title));
        screens.remove(title);
    }

}
