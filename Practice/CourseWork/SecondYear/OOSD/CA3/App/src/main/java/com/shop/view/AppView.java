package com.shop.view;

import javax.swing.BorderFactory;
import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.BorderLayout;

public class AppView extends JFrame {

    private Menu menu = new Menu();
    private Screens screens = new Screens();
    private Notifications notifications = new Notifications();

    public AppView() {
        setSize(1280, 720);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        JPanel panel = new JPanel(new BorderLayout(4, 4));
        panel.setBorder(BorderFactory.createEmptyBorder(12, 12, 12, 12));
        setContentPane(panel);

        menu.addActionListener(e -> screens.changeScreen(e.getActionCommand()));

        add(menu, BorderLayout.NORTH);
        add(screens, BorderLayout.CENTER);
        add(notifications, BorderLayout.SOUTH);

        menu.setVisible(false);
        setVisible(true);
    }


    public void addScreen(JPanel panel, String title) {
        screens.add(panel, title);
    }

    public void changeScreen(String title) {
        screens.changeScreen(title);
    }

    public void removeScreen(String title) {
        screens.removeScreen(title);
    }

    public void showMenu() {
        menu.setVisible(true);
    }

    public void hideMenu() {
        menu.setVisible(false);
    }
}
