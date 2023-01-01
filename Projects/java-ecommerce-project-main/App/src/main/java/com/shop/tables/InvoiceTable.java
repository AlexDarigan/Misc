package com.shop.tables;

import com.shop.repository.Repository;
import com.shop.models.InvoiceModel;

/**
 * The Invoice Table Controller
 * @author David Darigan
 * @version 0.1.0
 */
public class InvoiceTable extends Table {

    public InvoiceTable(Repository<InvoiceModel> repo) {
        super(repo, "");
    }
}
