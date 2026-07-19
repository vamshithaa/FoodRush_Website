package com.tap.model;

import java.sql.Timestamp;

public class Restuarant {
	private int restuarantId;
	private String resName;
	private String cuisineType;
	private Timestamp deliveryTime;
	private String address;
	private String imagePath;
	private float rating;
	private boolean isActive;
	private Integer ownerId;
	private boolean offerActive;
	private int offerPercent;
	
	
	public Restuarant() {
		super();
	}
	
	
	public String getFormattedDeliveryTime() {
	    if (deliveryTime == null) {
	        return "";
	    }

	    java.util.Calendar cal = java.util.Calendar.getInstance();
	    cal.setTime(deliveryTime);

	    int hours = cal.get(java.util.Calendar.HOUR_OF_DAY);
	    int minutes = cal.get(java.util.Calendar.MINUTE);

	    if (hours > 0) {
	        return hours + "h " + minutes + "m";
	    }
	    return minutes + " mins";
	}

	public Restuarant(int restuarantId, String resName, String cuisineType, Timestamp deliveryTime, String address,
			String imagePath, float rating, boolean isActive) {
		super();
		this.restuarantId = restuarantId;
		this.resName = resName;
		this.cuisineType = cuisineType;
		this.deliveryTime = deliveryTime;
		this.address = address;
		this.imagePath = imagePath;
		this.rating = rating;
		this.isActive = isActive;
	}


	public int getRestuarantId() {
		return restuarantId;
	}


	public void setRestuarantId(int restuarantId) {
		this.restuarantId = restuarantId;
	}


	public String getResName() {
		return resName;
	}


	public void setResName(String resName) {
		this.resName = resName;
	}


	public String getCuisineType() {
		return cuisineType;
	}


	public void setCuisineType(String cuisineType) {
		this.cuisineType = cuisineType;
	}


	public Timestamp getDeliveryTime() {
		return deliveryTime;
	}


	public void setDeliveryTime(Timestamp deliveryTime) {
		this.deliveryTime = deliveryTime;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public String getImagePath() {
		return imagePath;
	}


	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}


	public float getRating() {
		return rating;
	}


	public void setRating(float rating) {
		this.rating = rating;
	}


	public boolean isActive() {
		return isActive;
	}


	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}
	
	public Integer getOwnerId() {
	    return ownerId;
	}

	public void setOwnerId(Integer ownerId) {
	    this.ownerId = ownerId;
	}
	
	public boolean isOfferActive() {
	    return offerActive;
	}

	public void setOfferActive(boolean offerActive) {
	    this.offerActive = offerActive;
	}

	public int getOfferPercent() {
	    return offerPercent;
	}

	public void setOfferPercent(int offerPercent) {
	    this.offerPercent = offerPercent;
	}
	
	/** True only when there's a real, active discount to show/apply. */
	public boolean hasActiveOffer() {
	    return offerActive && offerPercent > 0;
	}

	@Override
	public String toString() {
	    return "Restuarant [restuarantId=" + restuarantId + ", resName=" + resName + ", cuisineType=" + cuisineType
	            + ", deliveryTime=" + deliveryTime + ", address=" + address + ", imagePath=" + imagePath + ", rating="
	            + rating + ", isActive=" + isActive + ", ownerId=" + ownerId + ", offerActive=" + offerActive
	            + ", offerPercent=" + offerPercent + "]";
	}
	
	
}
