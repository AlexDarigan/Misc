package com.shop.repository;

import com.shop.models.ProductModel;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

/** The Product Repository to manage read and write operations on Products
 * @author David Darigan
 * @version 0.1.0
 */
public class ProductRepository extends Repository<ProductModel> {

    /** Calls super with the specific column headers for the Repo */
    public ProductRepository() {
        super("Id", "Category", "Name",  "Price", "Quantity", "Action");
    }

    /** @return all valid updated models from the data source */
    @Override
    public HashMap<Integer, ProductModel> getAll() {
        models = tryReadAll();
        return models;
    }

    /** Reads all Product Rows from the Product Table where there is at least 1 Product */
    @Override
    public HashMap<Integer, ProductModel> readAll() throws SQLException {
        PreparedStatement stmt = prepareStatement("SELECT * from product WHERE quantity > 0");
        ResultSet r = stmt.executeQuery();
        while(r.next()) {
                int id = r.getInt("productId");
                String category = r.getString("category");
                String description = r.getString("description");
                float price = r.getFloat("price");
                int quantity = r.getInt("quantity");
                ProductModel p = new ProductModel(id, category, description, price, quantity);
                models.put(id, p);
        }
        return models;
    }

    /**
     * Updates the Product Row quantity based on the Product Model quantity
     * @param product The product model that row retrieves its new values from
     * @throws SQLException
     */
    public void update(ProductModel product) throws SQLException {
        PreparedStatement stmt = prepareStatement("UPDATE product SET quantity = ? WHERE productId = ?");
        stmt.setInt(1, product.getQuantity());
        stmt.setInt(2, product.getId());
        stmt.executeUpdate();
    }
}
