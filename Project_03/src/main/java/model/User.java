package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.connection;

public class User {
    private int userId;
    private Integer employeeId; // Có thể null
    private String username;
    private String password;
    private String role;
    private boolean isActive;
    private boolean isDeleted;

    // Constructor
    public User() {}

    public User(int userId, Integer employeeId, String username, String password, String role, 
                boolean isActive, boolean isDeleted) {
        this.userId = userId;
        this.employeeId = employeeId;
        this.username = username;
        this.password = password;
        this.role = role;
        this.isActive = isActive;
        this.isDeleted = isDeleted;
    }

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public Integer getEmployeeId() { return employeeId; }
    public void setEmployeeId(Integer employeeId) { this.employeeId = employeeId; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public boolean isActive() { return isActive; }
    public void setActive(boolean isActive) { this.isActive = isActive; }
    public boolean isDeleted() { return isDeleted; }
    public void setDeleted(boolean isDeleted) { this.isDeleted = isDeleted; }

    public static boolean isUsernameExists(String username) {
        try (Connection conn = connection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM TdtdUser WHERE TdtdUsername = ? AND TdtdIsDeleted = FALSE")) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    // Hàm lấy tất cả người dùng (chưa bị xóa) - static
    public static List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try (Connection conn = connection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM TdtdUser WHERE TdtdIsDeleted = FALSE");
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("TdtdUserId"));
                int empId = rs.getInt("TdtdEmployeeId");
                user.setEmployeeId(rs.wasNull() ? null : empId); // Xử lý null cho employeeId
                user.setUsername(rs.getString("TdtdUsername"));
                user.setPassword(rs.getString("TdtdPassword"));
                user.setRole(rs.getString("TdtdRole"));
                user.setActive(rs.getBoolean("TdtdIsActive"));
                user.setDeleted(rs.getBoolean("TdtdIsDeleted"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    // Hàm thêm người dùng - static
    public static void add(Integer employeeId, String username, String password, String role, boolean isActive) {
        try (Connection conn = connection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                 "INSERT INTO TdtdUser (TdtdEmployeeId, TdtdUsername, TdtdPassword, TdtdRole, TdtdIsActive, TdtdIsDeleted) VALUES (?, ?, ?, ?, ?, FALSE)")) {
            if (employeeId == null) {
                stmt.setNull(1, java.sql.Types.INTEGER);
            } else {
                stmt.setInt(1, employeeId);
            }
            stmt.setString(2, username);
            stmt.setString(3, password);
            stmt.setString(4, role);
            stmt.setBoolean(5, isActive);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Hàm sửa người dùng - static
    public static void update(int userId, Integer employeeId, String username, String password, String role, boolean isActive) {
        try (Connection conn = connection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                 "UPDATE TdtdUser SET TdtdEmployeeId = ?, TdtdUsername = ?, TdtdPassword = ?, TdtdRole = ?, TdtdIsActive = ? WHERE TdtdUserId = ? AND TdtdIsDeleted = FALSE")) {
            if (employeeId == null) {
                stmt.setNull(1, java.sql.Types.INTEGER);
            } else {
                stmt.setInt(1, employeeId);
            }
            stmt.setString(2, username);
            stmt.setString(3, password);
            stmt.setString(4, role);
            stmt.setBoolean(5, isActive);
            stmt.setInt(6, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Hàm xóa mềm người dùng - static
    public static void delete(int userId) {
        try (Connection conn = connection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                 "UPDATE TdtdUser SET TdtdIsDeleted = TRUE WHERE TdtdUserId = ?")) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}