package com.tap.model;

import java.sql.Timestamp;
import java.time.LocalDateTime;

public class User {
	private int userId;
	private String userName;
	private String userPassword;
	private String userEmail;
	private String userAddress;
	private String role;
	private Timestamp createdDate;
	private Timestamp LastLoginDate;
	private String resetToken;
	private java.sql.Timestamp resetTokenExpiry;
	
	
	public User() {
		super();
	}




	public User(String userName, String userPassword, String userEmail, String userAddress, String role) {
		super();
		this.userName = userName;
		this.userPassword = userPassword;
		this.userEmail = userEmail;
		this.userAddress = userAddress;
		this.role = role;
	}









	public User(int userId, String userName, String userPassword, String userEmail, String userAddress, String role,
			Timestamp createdDate, Timestamp lastLoginDate) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.userPassword = userPassword;
		this.userEmail = userEmail;
		this.userAddress = userAddress;
		this.role = role;
		this.createdDate = createdDate;
		this.LastLoginDate = lastLoginDate;
	}


	

	public int getUserId() {
		return userId;
	}


	public void setUserId(int userId) {
		this.userId = userId;
	}


	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}


	public String getUserPassword() {
		return userPassword;
	}


	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}


	public String getUserEmail() {
		return userEmail;
	}


	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}


	public String getUserAddress() {
		return userAddress;
	}


	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}


	public String getRole() {
		return role;
	}


	public void setRole(String role) {
		this.role = role;
	}


	public Timestamp getCreatedDate() {
		return createdDate;
	}


	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}


	public Timestamp getLastLoginDate() {
		return LastLoginDate;
	}


	public void setLastLoginDate(Timestamp lastLoginDate) {
		LastLoginDate = lastLoginDate;
	}
	
	public String getResetToken() {
	    return resetToken;
	}

	public void setResetToken(String resetToken) {
	    this.resetToken = resetToken;
	}

	public java.sql.Timestamp getResetTokenExpiry() {
	    return resetTokenExpiry;
	}

	public void setResetTokenExpiry(java.sql.Timestamp resetTokenExpiry) {
	    this.resetTokenExpiry = resetTokenExpiry;
	}


	@Override
	public String toString() {
		return "User [userId=" + userId + ", userName=" + userName + ", userPassword=" + userPassword + ", userEmail="
				+ userEmail + ", userAddress=" + userAddress + ", role=" + role + ", createdDate=" + createdDate
				+ ", LastLoginDate=" + LastLoginDate + "]";
	}
	
	
}
