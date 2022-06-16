package com.shop.models;

/** Represents a Product stored within a particular Customer's Cart
 * @author David Darigan
 * @version 0.1.0
 */
public class CartItemModel extends Model {

    private int customerId;
    private int quantity;
    private ProductModel product;

    public CartItemModel(int customerId, int quantity, ProductModel p) {
        this.customerId = customerId;
        this.product = p;
        this.quantity = quantity;
    }

    public int getId() { return product.getId();}

    /** @return the quantity of the product in the Customer's Cart */
    public int getQuantity() { return quantity; }

    /** @param  quantity set's the quantity of the product in the Customer's Cart when it is removed or added from the Cart */
    public void setQuantity(int quantity) { this.quantity = quantity; }

    /** @return the referenced price of the product this CartItem references */
    public float getPrice() { return product.getPrice(); }

    /** @return the referenced Product of this CartItem */
    public ProductModel getProduct() { return product; }

    @Override
    public String[] getData() {
        return new String[] {
                String.valueOf(product.getId()),
                product.getCategory(),
                product.getDescription(),
                String.format("$%.2f" , product.getPrice()),
                String.valueOf(quantity)
        };
    }
}
