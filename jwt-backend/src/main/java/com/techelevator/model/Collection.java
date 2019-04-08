package com.techelevator.model;

public class Collection {

	private long id;
	private String collection_name;
	private boolean public_bool;

	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
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
}