package com.shop.models;

import java.util.Date;

/** Represents an unique <emphasis>Invoice</emphasis>
 * @author David Darigan
 * @version 0.1.0
 */
public class InvoiceModel extends Model {

    private final int id;
    private final int customerId;
    private final Date date;
    private final float total;

    public InvoiceModel(int id, int customerId, Date date, float total)
    {
        this.id = id;
        this.customerId = customerId;
        this.date = date;
        this.total = total;
    }

    @Override
    public int getId() {
        return id;
    }

    @Override
    public String[] getData() {
        return new String[] {
                String.valueOf(id),
                String.valueOf(date),
                String.format("$%.2f" , total),
        };
    }
}
