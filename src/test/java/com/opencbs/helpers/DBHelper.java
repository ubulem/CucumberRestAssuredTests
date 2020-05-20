package com.opencbs.helpers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import static com.opencbs.constants.Constants.DB;

public class DBHelper {
    private static final Connection conn;
    private static final String DB_URL = DB;
    private static final String DB_USER = "someuser";
    private static final String DB_PASSWORD = "somepassword";

    static {
        try {
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (SQLException e) {
            throw new IllegalArgumentException("Driver cannot be initialized " + e.getMessage());
        }
    }

    public static void accruedInterestValidateOff() {
        String validateSQL = "UPDATE accounts SET validate_off=true WHERE 12 in (id, parent_id)";
        try (Statement stmt = conn.createStatement()) {
            stmt.executeUpdate(validateSQL);
        } catch (SQLException e) {
            throw new IllegalArgumentException("Update failed because of " + e.getMessage());
        }
    }
}