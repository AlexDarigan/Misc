package com.shop.repository;

/** A record of all in use Repositories intended to be used as a mediator to avoid unnecessary circular dependecies
 * @author David Darigan
 * @version 0.1.0
 */
public record Repositories(CartRepository cartRepo,
                           ProductRepository productRepo,
                           InvoiceRepository invoiceRepo) {
    // No Constructor Body
}
