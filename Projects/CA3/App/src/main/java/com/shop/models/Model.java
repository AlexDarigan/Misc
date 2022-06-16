package com.shop.models;

/** The base abstract class of all Domain Models
 * @author David Darigan
 * @version 0.1.0
 */
public abstract class Model {

    /** @return The model's unique ID used by Controllers to reference other instances of the same model (e.g a row in a database table) */
    public abstract int getId();

    /** @return a String[] row of the model's current values; */
    public abstract String[] getData();
}
