package com.tap.DAO;

import java.util.List;

import com.tap.model.User;

public interface UserDAO {
	int addUser(User user);
	User getUser(int userId);
	void deleteUser(int userId);
	void updateUser(User user);
	List<User>getAllUser();
	User getUserByUserEmail(String useremail);
	void setResetToken(String email, String token, java.sql.Timestamp expiry);
	User getUserByResetToken(String token);
	void resetPassword(int userId, String newHashedPassword);
}
