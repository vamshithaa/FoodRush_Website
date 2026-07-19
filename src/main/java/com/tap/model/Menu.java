package com.tap.model;

public class Menu {
	private int menuId;
	private int restuarantId;
	private String itemName;
	private String description;
	private float price;
	private String imagePath;
	private boolean isAvailable;
	
	
	public Menu() {
		
	}

	
	public Menu(int menuId, int restuarantId, String itemName, String description, float price, String imagePath,
			boolean isAvailable) {
		super();
		this.menuId = menuId;
		this.restuarantId = restuarantId;
		this.itemName = itemName;
		this.description = description;
		this.price = price;
		this.imagePath = imagePath;
		this.isAvailable = isAvailable;
	}


	public int getMenuId() {
		return menuId;
	}


	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}


	public int getRestuarantId() {
		return restuarantId;
	}


	public void setRestuarantId(int restuarantId) {
		this.restuarantId = restuarantId;
	}


	public String getItemName() {
		return itemName;
	}


	public void setItemName(String itemName) {
		this.itemName = itemName;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public float getPrice() {
		return price;
	}


	public void setPrice(float price) {
		this.price = price;
	}


	public String getImagePath() {
		return imagePath;
	}


	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}


	public boolean getisAvailable() {
		return isAvailable;
	}


	public void setAvailable(boolean isAvailable) {
		this.isAvailable = isAvailable;
	}


	@Override
	public String toString() {
		return "Menu [menuId=" + menuId + ", restuarantId=" + restuarantId + ", itemName=" + itemName + ", description="
				+ description + ", price=" + price + ", imagePath=" + imagePath + ", isAvailable=" + isAvailable + "]";
	}
	
	
}
