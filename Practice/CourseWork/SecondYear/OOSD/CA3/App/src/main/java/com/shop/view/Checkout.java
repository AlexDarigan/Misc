package com.shop.view;

import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.ActionListener;

public class Checkout extends JPanel {

    private final Dimension preferredSize = new Dimension(200, 20);
    private final ActionListener listener;
    private final Input cardHolderName = new Input("CardHolderName ");
    private final Input cardNumber = new Input("Card Number        ");
    private final Input securityCode = new Input("Security Code      ");

    public Checkout(ActionListener listener) {
        this.listener = listener;
        setLayout(new GridLayout(1, 3));
        JButton checkoutButton = new JButton("Checkout");
        checkoutButton.addActionListener(listener);

        JPanel content = new JPanel();
        content.setLayout(new BoxLayout(content, BoxLayout.Y_AXIS));
        content.add(Box.createVerticalGlue());
        content.add(cardHolderName);
        content.add(cardNumber);
        content.add(securityCode);
        content.add(Box.createRigidArea(new Dimension(0, 12)));
        content.add(checkoutButton);
        content.add(Box.createVerticalGlue());

        add(Box.createHorizontalGlue());
        add(content);
        add(Box.createHorizontalGlue());

    }

    public boolean validCard() {
        if(cardHolderName.getText().isBlank())
        {
            JOptionPane.showMessageDialog(null,
                    "Card Holder Name must not be blank",
                    "Invalid Card Holder Name", JOptionPane.ERROR_MESSAGE);
            cardNumber.clear();
            return false;
        }
        else if(!cardNumber.getText().matches("[0-9]{16}"))
        {
            JOptionPane.showMessageDialog(null,
                    "Card Number must be 16 digits",
                    "Invalid Card Number", JOptionPane.ERROR_MESSAGE);
            cardNumber.clear();
            return false;
        }
        else if(!securityCode.getText().matches("[0-9]{3}")) {
            JOptionPane.showMessageDialog(null,
                    "Card Security Code must be 3 digits",
                    "Invalid Security Code", JOptionPane.ERROR_MESSAGE);
            securityCode.clear();
            return false;
        }
        return true;
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
            add(label);
            add(input);
        }

        public String getText() {
            return input.getText();
        }

        public void clear() {
            input.setText("");
        }
    }
}
