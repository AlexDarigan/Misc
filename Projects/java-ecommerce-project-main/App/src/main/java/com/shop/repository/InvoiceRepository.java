package com.shop.repository;

import com.shop.models.CustomerModel;
import com.shop.models.InvoiceModel;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

/** The Invoice Repository to manage read and write operations on Invoices
 * @author David Darigan
 * @version 0.1.0
 */
public class InvoiceRepository extends Repository<InvoiceModel> {

    public InvoiceRepository() {
        super("Id", "Date", "Total");
    }


    @Override
    public HashMap<Integer, InvoiceModel> getAll() {
        models = tryReadAll();
        return tryReadAll();
    }

    /**
     * Create's a new Invoice
     * @param args The row data of the invoice to be created
     * @throws SQLException
     */
    @Override
    public void create(Object[] args) throws SQLException
    {
        PreparedStatement stmt = prepareStatement("INSERT into invoice (customerId, date, total) VALUES (?, ?, ?)");
        stmt.setInt(1, (int) args[0]);
        stmt.setDate(2, new java.sql.Date(System.currentTimeMillis()));
        stmt.setFloat(3, (float) args[1]);
        stmt.executeUpdate();
    }

    /**
     * @return  all valid updated invoices from the data source
     * @throws SQLException
     */
    @Override
    public HashMap<Integer, InvoiceModel> readAll() throws SQLException {
        PreparedStatement statement = prepareStatement("SELECT * from invoice WHERE customerId = ?");
        statement.setInt(1, CustomerModel.getInstance().getId());
        ResultSet r = statement.executeQuery();
        while(r.next()) {
            int invoiceId = r.getInt("invoiceId");
            int customerId = r.getInt("customerId");
            Date date = r.getDate("date");
            float cost = r.getFloat("total");
            InvoiceModel invoice = new InvoiceModel(invoiceId, customerId, date, cost);
            models.put(invoice.getId(), invoice);
        }
        return models;
    }
}
