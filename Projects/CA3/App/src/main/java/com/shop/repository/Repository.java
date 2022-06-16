package com.shop.repository;

import com.shop.SystemDatabase;
import com.shop.models.Model;
import javax.swing.table.DefaultTableModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;

/** The Repository class handles a collection of elements T which must extend Model
 * @param <T> The specific subclass of Model used for Repositories
 */

/** <h1>The Repository Class manages read and write access to a collection of Objects of Type T which must extend from the base Model Class</h1>
 *
 *  The Repository Class manages read and write access to a collection of Objects of Type T which must extend from the base Model Class.  The default
 *  implementation is for the Repository to handle data access from the data layer directly rather than using a dedicated Data Access Object.  Users may
 *  override the create, read, update and delete methods to work with non-sql data sources but there is no guarantee it will work. As Repository extends from
 *  DefaultTableModel it acts as the standard Model implementations for MVC Views (such as a JTable). Repositories have a one to one mapping relationship with
 *  their data sources.
 *
 * @author David Darigan
 * @version 0.1.0
 */
public class Repository<T extends Model> extends DefaultTableModel {

    private Connection conn;

    /** The internal HashMap consisting of the unique Model id and itself */
    protected HashMap<Integer, T> models = new HashMap<Integer, T>();

    /** @param fields The fields of the corresponding datasource table */
    public Repository(String... fields) {
        setColumnIdentifiers(fields);
    }

    /** Regenerates all table rows and informs any list through fireTableDataChanged() */
    public void update() {
        setDataVector(getAllRaw(), columnIdentifiers.toArray());
        fireTableDataChanged();
    }

    /** @return all Domain Models of Subclass T */
    public HashMap<Integer, T> getAll() {
        return models;
    }

    /**
     * @returns all models as rows in the Repository
     */
    public String[][] getAllRaw() {
        getAll();
        return models.values().stream().map(i -> i.getData()).toArray(String[][]::new);
    }

    /**  @param id a unique model id
     * @return the model corresponding to the id value;
     */
    public T getById(int id) {
        return models.get(id);
    }

    /** Tries to call a create procedure
     * @param args The row data of the object the Repository tries to create */
    public void tryCreate(Object... args) {
        try {
            create(args);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close();
        }
    }

    /** Tries to read a single instance of an object T from the Repository
     * @param args  Partial row data used for various PreparedStatement fields
     * @return the succesfully read Model of Type T
     */
    public T tryReadOne(Object[] args) {
        T model = null;
        try {
            model = readOne(args);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return model;
    }

    /**
     * Tries to read all Models fresh from the data source
     * @return an updated version of the internal HashMap<Integer, T> models;
     */
    public HashMap<Integer, T> tryReadAll() {
        models.clear();
        try {
            models = readAll();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return models;
    }

    /** Tries to update Model of Type T in the Repository*/
    public void tryUpdate(T model) {
        try {
            update(model);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close();
        }
    }

    /**
     * Tries to delete the Model of Type T from the Repository
     * @param model
     */
    public void tryDelete(T model) {
        try {
            delete(model);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close();
        }
    }


    /**
     * A method intended to be overridden by subclasses to define their own creation operations which will then be
     * called by the tryCreate method externally
     * @param args The row data of the model to be created
     * @throws SQLException
     */
    protected void create(Object[] args) throws SQLException {

    }

    /**
     *  A method intended to be overridden by subclasses to define their own read operations which will then be
     *  called by the tryReadOne method externally
     * @param args Partial row data used for various PreparedStatement fields
     * @return an instance of Type T
     * @throws SQLException
     */
    protected T readOne(Object[] args) throws SQLException {
        return null;
    }

    /**
     * A method intended to be overridden by subclasses to define their own readAll operations which will then be
     * called by the tryReadOne method externally
     * @return the updated Repository HashMap
     * @throws SQLException
     */
    protected HashMap<Integer, T> readAll() throws SQLException {
        return new HashMap<Integer, T>();
    }

    /**
     * A method intended to be overridden by subclasses to define their own update operations which will then be
     * called by the tryUpdate method externally.
     * @param model The model of Type T to be updated;
     * @throws SQLException
     */
    protected void update(T model) throws SQLException {

    }

    /**
     * A method intended to be overridden by subclasses to define their own delete operations which will then be
     * called by the tryDelete method externally
     * @param model The model of Type T to be deleted;
     * @throws SQLException
     */
    protected void delete(T model) throws SQLException {

    }

    /**
     *  Prepares a Statement while also opening a connection
     * @param sql The SQL Statement to be prepared
     * @return The PreparedStatement with the SQL;
     * @throws SQLException
     */
    protected PreparedStatement prepareStatement(String sql) throws SQLException {
        conn = SystemDatabase.tryGetConnection();
        PreparedStatement statement = conn.prepareStatement(sql);
        return statement;
    }

    /**
     * Closes the current connection opened by prepareStatement()
     */
    private void close(){
        if(conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }





}
