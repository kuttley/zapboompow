package com.techelevator.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.techelevator.authentication.AuthProvider;
import com.techelevator.authentication.JwtTokenHandler;
import com.techelevator.model.Collection;
import com.techelevator.model.ComicCollection;
import com.techelevator.model.JdbcCollectionDao;


@RestController
@RequestMapping("/collection")
@CrossOrigin
public class CollectionController {
	
	 @Autowired
	 private AuthProvider authProvider;
	 
	 @Autowired
	 private JdbcCollectionDao collectionDao;

	 @Autowired
	 private JwtTokenHandler tokenHandler;
	    
	    @RequestMapping(path="/{id}", method=RequestMethod.GET)
	    public Collection getCollection(@PathVariable long collection_id) throws CollectionNotFoundException {
	    	Collection collection = collectionDao.findById(collection_id);
	    	if(collection != null) {
	    	
	    		if(collection.isPublic_bool() == true) {
	    			return collection;
	    		} else if(collection.getUser_id() == authProvider.getCurrentUser().getId()) {
	    			return collection;
	    		}else {
		    		throw new CollectionNotFoundException(collection_id, "Can not view collection!");
	    		}
	    		
	    	} else {
	    		throw new CollectionNotFoundException(collection_id, "Collection not found!");
	    	}
	    }
	    
	    @RequestMapping(path="/all/{id}", method=RequestMethod.GET)
	    public List<Collection> getAllCollectionsForUser(@PathVariable long user_id) throws CollectionNotFoundException {
	    	List<Collection> collections = collectionDao.getCollectionByUserId(user_id);
	    	if(collections != null) {
	    	
	    		return collections;
	    	} else {
	    		throw new CollectionNotFoundException(0L, "Collections not found!");
	    	}
	    }
	
	    
	    @RequestMapping(path="/", method=RequestMethod.POST)
	    public Collection save(@Valid @RequestBody Collection collection, BindingResult result) throws CollectionCreationException {
	    	if(result.hasErrors()) {
	            String errorMessages = "";
	            for(ObjectError error : result.getAllErrors()) {
	                errorMessages += error.getDefaultMessage() + "\n";
	            }
	            throw new CollectionCreationException(errorMessages);
	    	}
	    	collection.setUser_id(authProvider.getCurrentUser().getId());
	    	return collectionDao.saveCollection(collection.getUser_id(), collection.getCollection_name(), collection.isPublic_bool());
	    
	    }
	    
	    
	    @RequestMapping(path="/add", method=RequestMethod.POST)
	    public void addComic(@Valid @RequestBody ComicCollection comicCollection, BindingResult result) throws CollectionNotFoundException {

	    	if(result.hasErrors()) {
	            String errorMessages = "";
	            for(ObjectError error : result.getAllErrors()) {
	                errorMessages += error.getDefaultMessage() + "\n";
	            }
	            throw new CollectionNotFoundException(comicCollection.getCollection_id(), errorMessages);
	    	}
	    	
	    	collectionDao.addComicToCollection(comicCollection.getCollection_id(), comicCollection.getComic_id());
	    
	    }
}