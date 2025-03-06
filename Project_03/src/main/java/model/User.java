package model;

public class User {
	private int userId;
	private Integer employeeId; // Integer để hỗ trợ null (vì UNIQUE nhưng không bắt buộc)
	private String username;
	private String password;
	private String role; // Có thể dùng enum nếu muốn
	private boolean isActive;

	// Constructor
	public User() {
	}

	public User(int userId, Integer employeeId, String username, String password, String role, boolean isActive) {
		this.userId = userId;
		this.employeeId = employeeId;
		this.username = username;
		this.password = password;
		this.role = role;
		this.isActive = isActive;
	}

	// Getters and Setters
	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public Integer getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(Integer employeeId) {
		this.employeeId = employeeId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public boolean isActive() {
		return isActive;
	}

	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}
}