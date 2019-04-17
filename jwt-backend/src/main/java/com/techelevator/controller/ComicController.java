package com.techelevator.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.techelevator.authentication.AuthProvider;
import com.techelevator.model.Comic;
import com.techelevator.model.JdbcComicDao;

@RestController
@RequestMapping("/comic")
@CrossOrigin
public class ComicController {

	 @Autowired
	 private AuthProvider authProvider;
	 @Autowired
	 private JdbcComicDao comicDao;
	 
	 @GetMapping("/id/{comic_id}")
	 public Comic getComicById(@PathVariable Long comic_id) throws ComicNotFoundException {
		 Comic comic = comicDao.getComicById(comic_id);
		 if (comic != null) {
			 return comic;
		 } else {
			 throw new ComicNotFoundException(comic_id, "Comic was not found.");
		 }
	 }
	 
	 @GetMapping("/title/{comic_title}")
	 public Comic getComicByTitle(@PathVariable String comic_title) throws ComicNotFoundException {
		 Comic comic = comicDao.getComicByTitle(comic_title);
		 
		 if (comic != null) {
			 return comic;
		 } else {
			 throw new ComicNotFoundException(0L, "Comic was not found.");
		 }
	 }
	 
	 @GetMapping("/creator/{comic_creator}")
	 public List<Comic> getComicsByCreator(@PathVariable String comic_creator) throws ComicNotFoundException {
		 List<Comic> comics = comicDao.getComicsByCreator(comic_creator);
		 
		 if (comics != null) {
			 return comics;
		 } else {
			 throw new ComicNotFoundException(0L, "No comics found.");
		 }
	 }
	 
	 @PostMapping()
	 public Comic addNewComic(@Valid @RequestBody Comic newComic, BindingResult result) throws ComicAddException {
		 if (result.hasErrors()) {
            String errorMessages = "";
            for(ObjectError error : result.getAllErrors()) {
                errorMessages += error.getDefaultMessage() + "\n";
            }
            throw new ComicAddException(errorMessages);
		 }
		 return comicDao.saveComic(newComic.getComic_id(), newComic.getComic_image(), newComic.getComic_title(), newComic.getComic_description(), newComic.getComic_release_date(), newComic.getComic_creators());
	 }
}
