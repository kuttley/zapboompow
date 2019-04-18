package com.techelevator.model;

import java.lang.reflect.Array;

public class Collection {

	private long user_id;
	private long collection_id;
	private String collection_name;
	private boolean public_bool;
	private long[] comic_ids_in_collection;
	private boolean featured;
	private long num_favorites;
	
	public Collection() {
		
	}

	public long getCollection_id() {
		return collection_id;
	}
	
	public void setCollection_id(long collection_id) {
		this.collection_id = collection_id;
	}

	public String getCollection_name() {
		return collection_name;
	}
	public void setCollection_name(String collection_name) {
		this.collection_name = collection_name;
	}
	public boolean isPublic_bool() {
		return public_bool;
	}
	public void setPublic_bool(boolean public_bool) {
		this.public_bool = public_bool;
	}

	public long getUser_id() {
		return user_id;
	}

	public void setUser_id(long user_id) {
		this.user_id = user_id;
	}

	public long[] getComic_ids_in_collection() {
		return comic_ids_in_collection;
	}

	public void setComic_ids_in_collection(long[] comic_ids_in_collection) {
		this.comic_ids_in_collection = comic_ids_in_collection;
	}

	public boolean isFeatured() {
		return featured;
	}

	public void setFeatured(boolean featured) {
		this.featured = featured;
	}
	
	public long getNum_favorites() {
		return this.num_favorites;
	}

	public void setNum_favorites(long num_favorites) {
		this.num_favorites = num_favorites;
	}

}