package com.shop.tables;

import com.shop.view.Checkout;
import com.shop.repository.Repository;
import com.shop.repository.CartRepository;
import com.shop.models.CartItemModel;
import com.shop.models.CustomerModel;
import com.shop.models.Model;
import com.shop.models.ProductModel;
import javax.swing.JOptionPane;
import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * The Cart Table Controller
 * @author David Darigan
 * @version 0.1.0
 */
public class CartTable extends Table {

    private final Checkout checkout = new Checkout(new OnCheckout());

    public CartTable(Repository<CartItemModel> repo) {
        super(repo, "Remove From Cart");
        view.add(checkout, BorderLayout.SOUTH);
    }

    /**
     * Adds a product to the Cart. If the CartItem already exists, its quantity is updated, otherwise a new instance is created
     * @param product
     */
    public void add(ProductModel product) {
        if(repository.getById(product.getId()) != null) {
            CartItemModel cartItem = (CartItemModel) repository.getById(product.getId());
            if(cartItem.getQuantity() < product.getQuantity()) {
                cartItem.setQuantity(cartItem.getQuantity() + 1);
                repository.tryUpdate(cartItem);
            }
        } else {
            repository.tryCreate(CustomerModel.getInstance().getId(), product);
        }
        update();
    }

    /**
     * Remove an item from cart when the "Remove From Cart" is pressed, if there is only 1 copy of it in the cart, then it is deleted otherwise
     * its quantity is reduced by one.
     * @param item The model to remove from the cart
     */
    public void onButtonPressed(Model item) {
        CartItemModel cartItem = (CartItemModel) item;
        cartItem.setQuantity(cartItem.getQuantity() - 1);
        if(cartItem.getQuantity() > 0) {
            repository.tryUpdate(cartItem);
        } else {
            repository.tryDelete(cartItem);
        }
        update();
    }

    /**
     * <h1>Handles Checking the products in the cart out</h1>
     * Makes sure the user cannot checkout with an Empty or Invalid Card. Once a checkout is confirmed:
     *  1. An invoice is created
     *  2. Quantity of the Products for sale is reduced by the quantity of their counterpart in that cart
     *  3. All of the cart items are deleted
     * @author David Darigan
     * @version 0.1.0
     */
    private class OnCheckout implements ActionListener
    {

        @Override
        public void actionPerformed(ActionEvent e) {
            if(repository.getAll().isEmpty()) {
                JOptionPane.showMessageDialog(null,
                        "No items to purchase",
                        "Empty Cart", JOptionPane.ERROR_MESSAGE);
                return;
            }
            else if(!checkout.validCard()) { return; }

            CartRepository cart = (CartRepository) repository;
            repos.invoiceRepo().tryCreate(CustomerModel.getInstance().getId(), cart.totalCost());
            for(CartItemModel item: cart.getAll().values()) {
                ProductModel p = item.getProduct();
                p.setQuantity(p.getQuantity() - item.getQuantity());
                repos.productRepo().tryUpdate(p);
                repository.tryDelete(item);
            }

            repos.invoiceRepo().update();
            repos.productRepo().update();
            update();
        }
    }
}
