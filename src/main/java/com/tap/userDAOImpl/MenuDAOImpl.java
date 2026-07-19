package com.tap.userDAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.MenuDAO;
import com.tap.Utility.DBConnection;
import com.tap.model.Menu;



public class MenuDAOImpl implements MenuDAO {
	public static final String INSERT_QUERY="INSERT INTO menu(restuarantId,itemName,description,price,imagePath,isAvailable) values(?,?,?,?,?,?)";
	public static final String SELECT_QUERY="SELECT * FROM menu WHERE menuId=?";
	public static final String DELETE_QUERY="DELETE FROM menu WHERE menuId=?";
	public static final String UPDATE_QUERY="UPDATE menu SET itemName=?,description=?,price=?,imagePath=?,isAvailable=? WHERE menuId=?";
	public static final String SELECT_ALL_QUERY="SELECT * FROM menu WHERE restuarantId=?";
	
	@Override
	public void addMenu(Menu menu) {
		
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pst=con.prepareStatement(INSERT_QUERY);
			pst.setInt(1,menu.getRestuarantId());
			pst.setString(2,menu.getItemName());
			pst.setString(3, menu.getDescription());
			pst.setFloat(4, menu.getPrice());
			pst.setString(5, menu.getImagePath());
			pst.setBoolean(6, menu.getisAvailable());
			
			
			int i=pst.executeUpdate();
			System.out.println(i+" Row Updated");
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public Menu getMenu(int menuId) {
		Menu menu=null;
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pst=con.prepareStatement(SELECT_QUERY);
			pst.setInt(1,menuId);
			ResultSet res=pst.executeQuery();
			
			while(res.next()) {
				int menuid=res.getInt("menuId");
				int resid=res.getInt("restuarantId");
				String itemName=res.getString("itemName");
				String description=res.getString("description");
				float price=res.getFloat("price");
				String imagePath=res.getString("imagePath");
				boolean isAvailable=res.getBoolean("isAvailable");
				
				menu=new Menu(menuid,resid,itemName,description,price,imagePath,isAvailable);
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return menu;
	}

	@Override
	public void deleteMenu(int menuId) {
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pst=con.prepareStatement(DELETE_QUERY);
			pst.setInt(1, menuId);
			pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	@Override
	public void updateMenu(Menu menu) {
		Connection con=DBConnection.getConnection();
		try {
			PreparedStatement pst=con.prepareStatement(UPDATE_QUERY);
			pst.setString(1,menu.getItemName());
			pst.setString(2, menu.getDescription());
			pst.setFloat(3, menu.getPrice());
			pst.setString(4, menu.getImagePath());
			pst.setBoolean(5, menu.getisAvailable());
			pst.setInt(6, menu.getMenuId());
			
			int i=pst.executeUpdate();
			System.out.println(i+" Row Affected");
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Menu> getAllMenu(int restuarantId) {
		
		List<Menu> list=new ArrayList<>();
		Connection con=DBConnection.getConnection();
		
		try {
			PreparedStatement st=con.prepareStatement(SELECT_ALL_QUERY);
			st.setInt(1, restuarantId);
			ResultSet res=st.executeQuery();
			
			while(res.next()) {
				Menu menu=new Menu();
				menu.setMenuId(res.getInt("menuId"));
				menu.setRestuarantId(res.getInt("restuarantId"));
				menu.setItemName(res.getString("itemName"));
				menu.setDescription(res.getString("description"));
				menu.setPrice(res.getFloat("price"));
				menu.setImagePath(res.getString("imagePath"));
				menu.setAvailable(res.getBoolean("isAvailable"));
				
				list.add(menu);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
}
