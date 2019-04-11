package com.techelevator.model;

import java.lang.reflect.Array;

public class Collection {

	private long user_id;
	private long collection_id;
	private String collection_name;
	private boolean public_bool;
	
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

}