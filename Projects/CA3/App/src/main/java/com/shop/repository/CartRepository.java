package com.shop.repository;

import com.shop.models.CartItemModel;
import com.shop.models.CustomerModel;
import com.shop.models.ProductModel;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

/** The Cart Repository to manage read and write operations on CartItems
 * @author David Darigan
 * @version 0.1.0
 */
public class CartRepository extends Repository<CartItemModel> {

    public CartRepository() {
        super("Id", "Category", "Name", "Price", "Quantity", "Action");
    }

    /** @return the sum cost of all products currently in the cart */
    public float totalCost() {
        return models.values().stream().map(i -> i.getQuantity() * i.getPrice()).reduce(0f, (a, b) -> a + b);
    }

    @Override
    public HashMap<Integer, CartItemModel> getAll() {
        models = tryReadAll();
        return tryReadAll();
    }

    /**
     * Create's a new CartItem
     * @param args The row data of the cartItem to be created
     * @throws SQLException
     */
    @Override
    public void create(Object[] args) throws SQLException {
        PreparedStatement stmt = prepareStatement(
                "INSERT into cart (customerId, productId) VALUES (?, ?)");
        stmt.setInt(1, (int) args[0]);
        ProductModel p = (ProductModel) args[1];
        stmt.setInt(2, p.getId());
        CartItemModel item = new CartItemModel((int) args[0], 1, p);
        models.put(item.getId(), item);
        stmt.executeUpdate();
    }

    /**
     * @return  all valid cart items from the data source
     * @throws SQLException
     */
    @Override
    public HashMap<Integer, CartItemModel> readAll() throws SQLException {
        PreparedStatement statement = prepareStatement(
                "SELECT * FROM product INNER JOIN cart ON product.productId = cart.productId " +
                        "WHERE customerId = ?");
        statement.setInt(1, CustomerModel.getInstance().getId());
        ResultSet r = statement.executeQuery();
        while(r.next()) {
            int id = r.getInt("product.productId");
            String category = r.getString("category");
            String description = r.getString("description");
            float price = r.getFloat("price");
            int productQuantity = r.getInt("product.quantity");
            ProductModel p = new ProductModel(id, category, description, price, productQuantity);
            int cartQuantity = r.getInt("cart.quantity");
            CartItemModel cartItem = new CartItemModel(CustomerModel.getInstance().getId(), cartQuantity, p);
            models.put(id, cartItem);
        }
        return models;
    }

    /**
     * Updates the Cart Item Row quantity
     * @param cartItem The product model that row retrieves its new values from
     * @throws SQLException
     */
    public void update(CartItemModel cartItem) throws SQLException {
        PreparedStatement statement = prepareStatement(
                "UPDATE cart SET quantity = ? WHERE productId = ? AND customerId = ?");
        statement.setInt(1, cartItem.getQuantity());
        statement.setInt(2, cartItem.getId());
        statement.setInt(3, CustomerModel.getInstance().getId());
        statement.executeUpdate();
    }

    /**
     * Deletes a cart item from the repo and data source
     * @param cartItem The cart item to be deleted
     * @throws SQLException
     */
    @Override
    public void delete(CartItemModel cartItem) throws SQLException {
        PreparedStatement statement = prepareStatement(
                "DELETE FROM cart WHERE productId = ? AND customerId = ?");
        statement.setInt(1, cartItem.getId());
        statement.setInt(2, CustomerModel.getInstance().getId());
        statement.executeUpdate();
    }
}
