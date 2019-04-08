package com.techelevator.controller;

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
	    public Collection getCollection(@PathVariable Long id) throws CollectionNotFoundException {
	    	Collection collection = collectionDao.findById(id);
	    	if(collection != null && collection.getId() == authProvider.getCurrentUser().getId()) {
	    		return collection;
	    	} else {
	    		throw new CollectionNotFoundException(id, "Collection not found!");
	    	}
	    }
	
	    
	    @RequestMapping(path="/", method=RequestMethod.POST)
	    public String save(@Valid @RequestBody Collection collection, BindingResult result) throws CollectionCreationException {
	    	if(result.hasErrors()) {
	            String errorMessages = "";
	            for(ObjectError error : result.getAllErrors()) {
	                errorMessages += error.getDefaultMessage() + "\n";
	            }
	            throw new CollectionCreationException(errorMessages);
	    	}
	    	collection.setId(authProvider.getCurrentUser().getId());
	    	collectionDao.saveCollection(collection);
	    	return "{\"success\":true}";
	    }
}
