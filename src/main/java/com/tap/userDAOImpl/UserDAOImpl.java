package com.tap.userDAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.UserDAO;
import com.tap.Utility.DBConnection;
import com.tap.model.User;


public class UserDAOImpl implements UserDAO {
	public static final String INSERT_QUERY="INSERT INTO user(userName,userPassword,userEmail,userAddress,role,createdDate,lastLoginDate) values(?,?,?,?,?,?,?)";
	public static final String SELECT_QUERY="SELECT * FROM user WHERE userId=?";
	public static final String DELETE_QUERY="DELETE FROM user WHERE userId=?";
	public static final String UPDATE_QUERY="UPDATE user SET userName=?,userPassword=?,userEmail=?,userAddress=?,role=?,lastLoginDate=? WHERE userId=?";
	public static final String SELECT_ALL_QUERY="SELECT * FROM user";
	public static final String SELECT_USER_BY_EMAIL="SELECT * FROM user WHERE userEmail=?";
	public static final String SET_RESET_TOKEN_QUERY = "UPDATE user SET resetToken=?, resetTokenExpiry=? WHERE userEmail=?";
	public static final String SELECT_BY_RESET_TOKEN_QUERY = "SELECT * FROM user WHERE resetToken=?";
	public static final String RESET_PASSWORD_QUERY = "UPDATE user SET userPassword=?, resetToken=NULL, resetTokenExpiry=NULL WHERE userId=?";
	
	@Override
	public int addUser(User user) {
		
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pst=con.prepareStatement(INSERT_QUERY);
			pst.setString(1,user.getUserName());
			pst.setString(2, user.getUserPassword());
			pst.setString(3, user.getUserEmail());
			pst.setString(4, user.getUserAddress());
			pst.setString(5, user.getRole());
			pst.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
			pst.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
			
			int i=pst.executeUpdate();
			return i;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public User getUser(int userId) {
		User user=null;
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pst=con.prepareStatement(SELECT_QUERY);
			pst.setInt(1,userId);
			ResultSet res=pst.executeQuery();
			
			while(res.next()) {
				int id=res.getInt("userId");
				String userName=res.getString("userName");
				String password=res.getString("userPassword");
				String email=res.getString("userEmail");
				String address=res.getString("userAddress");
				//changed from String role=res.getString("userRole"); to String role=res.getString("role"); for profile section implementaion
				String role=res.getString("role");
				Timestamp createdDate=res.getTimestamp("createdDate");
				Timestamp lastLoginDate=res.getTimestamp("lastLoginDate");
				
				user=new User(id,userName,password,email, address,role,createdDate,lastLoginDate);
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return user;
	}

	@Override
	public void deleteUser(int userId) {
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pst=con.prepareStatement(DELETE_QUERY);
			pst.setInt(1, userId);
			pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	@Override
	public void updateUser(User user) {
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pst=con.prepareStatement(UPDATE_QUERY);
			pst.setString(1,user.getUserName());
			pst.setString(2, user.getUserPassword());
			pst.setString(3, user.getUserEmail());
			pst.setString(4, user.getUserAddress());
			pst.setString(5, user.getRole());
			pst.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
			pst.setInt(7, user.getUserId());
			
			int i=pst.executeUpdate();
			System.out.println(i+" Row Affected");
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<User> getAllUser() {
		
		List<User> list=new ArrayList<User>();
		Connection con=DBConnection.getConnection();
		
		try {
			Statement st=con.createStatement();
			ResultSet res=st.executeQuery(SELECT_ALL_QUERY);
			
			while(res.next()) {
				int id=res.getInt("userId");
				String userName=res.getString("userName");
				String password=res.getString("userPassword");
				String email=res.getString("userEmail");
				String address=res.getString("userAddress");
				String role=res.getString("role");
				Timestamp createdDate=res.getTimestamp("createdDate");
				Timestamp lastLoginDate=res.getTimestamp("lastLoginDate");
				
				User user=new User(id,userName,password,email, address,role,createdDate,lastLoginDate);
				list.add(user);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	
	
	@Override
	public User getUserByUserEmail(String useremail) {
		User user=null;
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pst=con.prepareStatement(SELECT_USER_BY_EMAIL);
			pst.setString(1, useremail);
			ResultSet rs=pst.executeQuery();
			
			if(rs.next()) {
				user= new User();
				user.setUserId(rs.getInt("userId"));
				user.setUserName(rs.getString("userName"));
				user.setUserPassword(rs.getString("userPassword"));
				user.setUserEmail(rs.getString("userEmail"));
				user.setUserAddress(rs.getString("userAddress"));
				user.setRole(rs.getString("role"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return user;
		
	}
	@Override
	public void setResetToken(String email, String token, Timestamp expiry) {
	    Connection con = DBConnection.getConnection();
	    try {
	        PreparedStatement pst = con.prepareStatement(SET_RESET_TOKEN_QUERY);
	        pst.setString(1, token);
	        pst.setTimestamp(2, expiry);
	        pst.setString(3, email);
	        pst.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

	@Override
	public User getUserByResetToken(String token) {
	    User user = null;
	    Connection con = DBConnection.getConnection();
	    try {
	        PreparedStatement pst = con.prepareStatement(SELECT_BY_RESET_TOKEN_QUERY);
	        pst.setString(1, token);
	        ResultSet rs = pst.executeQuery();

	        if (rs.next()) {
	            user = new User();
	            user.setUserId(rs.getInt("userId"));
	            user.setUserName(rs.getString("userName"));
	            user.setUserPassword(rs.getString("userPassword"));
	            user.setUserEmail(rs.getString("userEmail"));
	            user.setUserAddress(rs.getString("userAddress"));
	            user.setRole(rs.getString("role"));
	            user.setResetToken(rs.getString("resetToken"));
	            user.setResetTokenExpiry(rs.getTimestamp("resetTokenExpiry"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return user;
	}

	@Override
	public void resetPassword(int userId, String newHashedPassword) {
	    Connection con = DBConnection.getConnection();
	    try {
	        PreparedStatement pst = con.prepareStatement(RESET_PASSWORD_QUERY);
	        pst.setString(1, newHashedPassword);
	        pst.setInt(2, userId);
	        pst.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

	
	
}
