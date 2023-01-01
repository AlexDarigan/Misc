package com.shop;

import com.shop.repository.*;
import com.shop.models.CustomerModel;
import com.shop.tables.*;
import com.shop.view.AppView;
import com.shop.view.Login;

import javax.swing.JLabel;
import javax.swing.JOptionPane;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

/** The applications main window
 * @author David Darigan
 * @version 0.1.0
 */
public class App {


    private AppView view = new AppView();
    private InvoiceRepository invoiceRepo = new InvoiceRepository();
    private CartRepository cartRepo = new CartRepository();
    private ProductRepository productRepo = new ProductRepository();
    private InvoiceTable invoiceTable = new InvoiceTable(invoiceRepo);
    private CartTable cartTable = new CartTable(cartRepo);
    private ProductTable productTable = new ProductTable(cartTable, productRepo);
    private Repositories tables = new Repositories(cartRepo, productRepo, invoiceRepo);
    private CustomerRepository customers = new CustomerRepository();
    private Login login = new Login();

    /**
     * The applications default entry point
     * @param args
     */
    public static void main(String[] args) {
        new App();
    }

    public App()
    {
        invoiceTable.setRepos(tables);
        cartTable.setRepos(tables);
        productTable.setRepos(tables);
        login.addActionListener(new OnLoginDetailsEntered());
        view.addWindowListener(new OnWindowClosed());
        view.setVisible(false);
        view.addScreen(login, "Login");
        view.setVisible(true);
    }


    private class OnLoginDetailsEntered implements ActionListener {

        @Override
        public void actionPerformed(ActionEvent e) {
            String username = login.getUsername();
            String password = login.getPassword();
            CustomerModel customer = customers.login(username, password);
            if (customer == null) {
                JOptionPane.showMessageDialog(new JLabel(), "Customer not found");
                return;
            }
            JOptionPane.showMessageDialog(new JLabel(), "Welcome " + customer.getUsername());
            invoiceTable.update();
            cartTable.update();
            productTable.update();
            view.showMenu();
            view.remove(login);
            view.addScreen(invoiceTable.getView(), "View Orders");
            view.addScreen(cartTable.getView(), "View Cart");
            view.addScreen(productTable.getView(), "Browse Items");
            view.changeScreen("Browse Items");
        }
    }


    private class OnWindowClosed extends WindowAdapter
    {
        @Override
        public void windowClosing(WindowEvent e) {
            if(CustomerModel.getInstance() != null) {
                customers.logout(CustomerModel.getInstance());
            }
            super.windowClosing(e);
        }
    }
}
