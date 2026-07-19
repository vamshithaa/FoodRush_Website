package com.tap.DAO;

import java.util.List;

import com.tap.model.Restuarant;

public interface RestuarantDAO {
	void addRestuarant(Restuarant restaurant);
	Restuarant getRestuarant(int RestuarantId);
	void deleteRestuarant(int RestuarantId);
	void updateRestuarant(Restuarant restuarant);
	List<Restuarant>getAllRestuarant();
	Restuarant getRestuarantByOwnerId(int ownerId);
}