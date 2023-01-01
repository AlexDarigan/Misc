package com.shop.repository;

import com.shop.models.CustomerModel;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/** The Customer Repository to manage read and write operations on Customers
 * @author David Darigan
 * @version 0.1.0
 */
public class CustomerRepository extends Repository<CustomerModel> {

    public CustomerRepository() {
        super();
    }

    /**
     * Logins a customer into the Application
     * @param username The username input by the current User
     * @param password The password input by the current User
     * @return a logged in Customer;
     */
    public CustomerModel login(String username, String password) {
        CustomerModel customer = tryReadOne(new String[]{username, password});
        customer.setLoggedIn(true);
        tryUpdate(customer);
        return customer;
    }

    /**
     * Logs a customer out of the application
     * @param customer the customer to be logged out
     */
    public void logout(CustomerModel customer) {
        customer.setLoggedIn(false);
        tryUpdate(customer);
    }

    /**
     * Reads a user from the data source
     * @param args Partial row data used for various PreparedStatement fields
     * @return the read Customer
     * @throws SQLException
     */
    @Override
    protected CustomerModel readOne(Object[] args) throws SQLException {
        PreparedStatement statement = prepareStatement(
                "SELECT * FROM customer WHERE username = ? and password = ?");
        statement.setString(1, (String) args[0]);
        statement.setString(2, (String) args[1]);
        ResultSet r = statement.executeQuery();
        CustomerModel customer = null;
        while(r.next()) {
            int id = r.getInt("customerId");
            String username = r.getString("username");
            String email = r.getString("email");
            Date dob = r.getDate("dob");
            String phone = r.getString("phone");
            boolean loggedIn = r.getBoolean("logged_in");
            customer = new CustomerModel(id, username, email, dob, phone, loggedIn);
        }
        return customer;
    }

    /**
     * Updates the customer row in the data source to match the customer model
     * @param customer the customer model
     * @throws SQLException
     */
    @Override
    public void update(CustomerModel customer) throws SQLException {
        PreparedStatement statement = prepareStatement(
                "UPDATE customer SET username = ?, email = ?, dob = ?, " +
                        "phone = ?, logged_in = ? WHERE customerId = ?");
        statement.setString(1, customer.getUsername());
        statement.setString(2, customer.getEmail());
        statement.setDate(3, customer.getDob());
        statement.setString(4, customer.getPhone());
        statement.setBoolean(5, customer.getLoggedIn());
        statement.setInt(6, customer.getId());
        statement.executeUpdate();
    }
}
