package com.shop.view;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JPanel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class Menu extends JPanel {

    private JButton browseItems = new JButton("Browse Items");
    private JButton viewOrders = new JButton("View Orders");
    private JButton viewCart = new JButton("View Cart");

    public Menu() {
        add(browseItems);
        add(viewOrders);
        add(viewCart);
        setBorder(BorderFactory.createEtchedBorder());

    }

    public void addActionListener(ActionListener listener) {
        browseItems.addActionListener(listener);
        viewOrders.addActionListener(listener);
        viewCart.addActionListener(listener);
    }
}
