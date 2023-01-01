package com.shop.view;

import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.ActionListener;


public class Login extends JPanel {

    private final Dimension preferredSize = new Dimension(140, 20);
    private final Input userName = new Input("Username ");
    private final HiddenInput password = new HiddenInput("Password ");
    private final JButton loginButton = new JButton("Login");

    public Login() {
        setLayout(new GridLayout(1, 3));

        JPanel content = new JPanel();
        content.setLayout(new BoxLayout(content, BoxLayout.Y_AXIS));
        content.add(Box.createVerticalGlue());
        content.add(userName);
        content.add(password);
        content.add(Box.createRigidArea(new Dimension(0, 12)));
        content.add(loginButton);
        content.add(Box.createVerticalGlue());

        add(Box.createHorizontalGlue());
        add(content);
        add(Box.createHorizontalGlue());
    }

    public void addActionListener(ActionListener listener) {
        loginButton.addActionListener(listener);
    }

    public String getUsername() {
        return userName.getText();
    }

    public String getPassword() {
        return password.getText();
    }

    private class Input extends JPanel
    {
        private JLabel label = new JLabel();
        private JTextField input = new JTextField();

        public Input(String title) {
            label.setText(title);
            setLayout(new BoxLayout(this, BoxLayout.X_AXIS));
            label.setMaximumSize(preferredSize);
            input.setMaximumSize(preferredSize);
            label.setMinimumSize(preferredSize);
            input.setMaximumSize(preferredSize);
            add(label);
            add(input);
        }

        public String  getText() {
            return input.getText();
        }
    }

    private class HiddenInput extends JPanel
    {
        private JLabel label = new JLabel();
        private JPasswordField input = new JPasswordField();

        public HiddenInput(String title) {
            label.setText(title);
            setLayout(new BoxLayout(this, BoxLayout.X_AXIS));
            label.setMaximumSize(preferredSize);
            input.setMaximumSize(preferredSize);
            add(label);
            add(input);
        }

        public String  getText() {
            return String.valueOf(input.getPassword());
        }
    }
}
