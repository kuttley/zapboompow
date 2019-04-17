package com.techelevator.model;

import java.sql.Date;
import java.util.List;

public class Comic {
	
	private long comic_id;
	private String comic_image;
	private String comic_title;
	private String comic_description;
	private Date comic_release_date;
	private String comic_creators;
	
	public Comic() {
		
	}
	
	public long getComic_id() {
		return comic_id;
	}
	public void setComic_id(long comic_id) {
		this.comic_id = comic_id;
	}
	public String getComic_image() {
		return comic_image;
	}
	public void setComic_image(String comic_image) {
		this.comic_image = comic_image;
	}
	public String getComic_title() {
		return comic_title;
	}
	public void setComic_title(String comic_title) {
		this.comic_title = comic_title;
	}
	public String getComic_description() {
		return comic_description;
	}
	public void setComic_description(String comic_description) {
		this.comic_description = comic_description;
	}
	public Date getComic_release_date() {
		return comic_release_date;
	}
	public void setComic_release_date(Date comic_release_date) {
		this.comic_release_date = comic_release_date;
	}
	public String getComic_creators() {
		return comic_creators;
	}
	public void setComic_creators(String comic_creators) {
		this.comic_creators = comic_creators;
	}
}

