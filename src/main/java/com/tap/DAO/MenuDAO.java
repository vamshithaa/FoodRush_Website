package com.tap.DAO;

import java.util.List;

import com.tap.model.Menu;

public 	interface MenuDAO {
	void addMenu(Menu menu);
	Menu getMenu(int menuId);
	void deleteMenu(int menuId);
	void updateMenu(Menu menu);
	List<Menu>getAllMenu(int restuarantId);
}
