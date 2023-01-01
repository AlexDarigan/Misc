package com.shop.models;

/** Represents a unique <emphasis>Product</emphasis>
 * @author David Darigan
 * @version 0.1.0
 */
public class ProductModel extends Model {

    private final int id;
    private final String category;
    private final String description;
    private final float price;
    private int quantity;

    public ProductModel(int id, String category, String desc, float price, int quantity) {
        this.id = id;
        this.category = category;
        this.description = desc;
        this.price = price;
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    /** @return the product's category (e.g <i>Sports</i> or <i>Kitchen</i>) */
    public String getCategory() { return category; }

    /** @return the product's name or description */
    public String getDescription() { return description; }

    /** @return the product's price */
    public float getPrice() { return price; }

    /** @return the product's current quantity in stock */
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }


    @Override
    public String[] getData() {
        return new String[] {
                String.valueOf(id),
                category,
                description,
                String.format("$%.2f" , price),
                String.valueOf(quantity)
        };
    }
}
