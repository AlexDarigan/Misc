package com.shop;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/** The SystemDatabase
 * @author David Darigan
 * @version 0.1.0
 */
public class SystemDatabase {

    /** Returns either a Connection object or null
     * @return Connection
     */
    public static Connection tryGetConnection() {
        Connection connection = null;
        try {
            connection = getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }

    /** Tries to close an existing connection
     * @param conn - An active Connection object
     */
    public static void tryCloseConnection(Connection conn) {
        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static Connection getConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://" + System.getenv("user") + ":" + System.getenv("pass") +
                "@collegedb-do-user-11033387-0.b.db.ondigitalocean.com:25060/defaultdb?ssl-mode=REQUIRED");
    }
}
