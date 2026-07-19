package com.tap.model;

public class CartItem {
	private int menuId;
	private int restuarantId;
	private String name;
	private float price;
	private int quantity;
	private int discountPercent;
	
	
	
	public CartItem() {
		
	}



	public CartItem(int menuId, int restuarantId, String name, float price, int quantity) {
		super();
		this.menuId = menuId;
		this.restuarantId = restuarantId;
		this.name = name;
		this.price = price;
		this.quantity = quantity;
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



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public float getPrice() {
		return price;
	}



	public void setPrice(float price) {
		this.price = price;
	}



	public int getQuantity() {
		return quantity;
	}



	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	
	/** Original total before any discount — useful for showing a strikethrough price. */
	public int getOriginalTotalPrice() {
	    return (int)(quantity*price);
	}

	/** Actual total the customer pays, after applying this item's discount (if any). */
	public int getTotalPrice() {
	    float effectivePrice = price * (100 - discountPercent) / 100f;
	    return (int)(quantity*effectivePrice);
	}
	
	public int getDiscountPercent() {
	    return discountPercent;
	}

	public void setDiscountPercent(int discountPercent) {
	    this.discountPercent = discountPercent;
	}



	@Override
	public String toString() {
		return "CartItem [menuId=" + menuId + ", restuarantId=" + restuarantId + ", name=" + name + ", price=" + price
				+ ", quantity=" + quantity + "]";
	}
	
	
	
	
}
