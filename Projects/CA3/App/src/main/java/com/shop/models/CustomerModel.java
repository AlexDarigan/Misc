package com.shop.models;

import java.sql.Date;

/** Represents an unique <emphasis>Customer</emphasis>
 * @author David Darigan
 * @version 0.1.0
 */
public class CustomerModel extends Model {

    private int id;
    private String username;
    private String email;
    private Date dob;
    private String phone;
    private boolean loggedIn = false;
    private static CustomerModel instance;

    public CustomerModel(int id, String username, String email, Date dob, String phone, boolean loggedIn) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.dob = dob;
        this.phone = phone;
        this.loggedIn = loggedIn;
        instance = this;
    }

    /**
     *  @return The Customer Model for the currently logged in Customer
     */
    public static CustomerModel getInstance() { return instance; }

    @Override
    public int getId() { return id; }

    /** @return the Customer's username*/
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    /** @return the Customer's email*/
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    /** @return the Customer's date of birth*/
    public Date getDob() { return this.dob; }
    public void setDob(Date dob) { this.dob = dob; }

    /** @return the Customer's phone number */
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    /** @return true if the Customer is currently loggedIn */
    public boolean getLoggedIn() { return loggedIn; }

    /** @param loggedIn (set to true if the customer is logged in, otherwise false) */
    public void setLoggedIn(boolean loggedIn) { this.loggedIn = loggedIn; }

    @Override
    public String[] getData() {
        return new String[]{String.valueOf(id), username, email,
                String.valueOf(dob), phone, String.valueOf(loggedIn)};
    }
}
