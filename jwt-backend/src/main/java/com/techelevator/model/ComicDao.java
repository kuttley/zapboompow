package com.techelevator.model;

import java.sql.Date;
import java.util.List;


public interface ComicDao {
	public Comic saveComic(long comic_id, String comic_image, String comic_title, String comic_description, Date comic_release_date, String comic_creators);
	public Comic getComicById(long comic_id);
	public Comic getComicByTitle(String comic_title);
	public List<Comic> getComicsByCreator(String comic_creator);
}
