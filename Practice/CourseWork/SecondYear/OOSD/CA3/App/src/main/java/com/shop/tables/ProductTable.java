package com.shop.tables;

import com.shop.repository.Repository;
import com.shop.models.Model;
import com.shop.models.ProductModel;

/**
 * The Product Table Controller
 * @author David Darigan
 * @version 0.1.0
 */
public class ProductTable extends Table {

    private CartTable cartTable;

    public ProductTable(CartTable cartTable, Repository<ProductModel> repo) {
        super(repo, "Add To Cart");
        this.cartTable = cartTable;
    }

    /**
     * Adds a Product to the Cart when the Add To Cart option is selected
     * @param model The product to be added to the cart
     */
    protected void onButtonPressed(Model model) {
        cartTable.add((ProductModel)  model);
    }
}

