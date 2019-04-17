package com.techelevator.controller;

import java.util.ArrayList;
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
	    
	    @RequestMapping(path="/{collection_id}", method=RequestMethod.GET)
	    public Collection getCollection(@PathVariable Long collection_id) throws CollectionNotFoundException {
	    	Collection collection = collectionDao.findById(collection_id);
	    	if(collection != null) {
	    	
	    		if(collection.isPublic_bool() == true) {
	    			return collection;
	    		} else if(authProvider.getCurrentUser() != null && collection.getUser_id() == authProvider.getCurrentUser().getId()) {
	    			return collection;
	    		} else {
		    		return null;
	    		}
	    		
	    	} else {
	    		throw new CollectionNotFoundException(collection_id, "Collection not found!");
	    	}
	    }
	    
	    @PostMapping("/delete")
	    public boolean deleteCollection(@RequestBody Long collection_id) throws CollectionNotFoundException {
	    	Collection collectionToDelete = collectionDao.findById(collection_id);
	    	if (authProvider.getCurrentUser() != null && authProvider.getCurrentUser().getId() == collectionToDelete.getUser_id()) {
		    	if (!collectionDao.deleteCollection(collection_id)) {
		    		throw new CollectionNotFoundException(collection_id, "Collection not found!");
		    	}
		    	
		    	return true;
	    	} else {
	    		return false;
	    	}
	    }
	    
	    @PostMapping("/rename")
	    public boolean renameCollection(@RequestBody Collection renamedCollection) throws CollectionNotFoundException {
	    	if (authProvider.getCurrentUser() != null && authProvider.getCurrentUser().getId() == renamedCollection.getUser_id()) {
	    		if (!collectionDao.changeCollectionName(renamedCollection.getCollection_id(), renamedCollection.getCollection_name())) {
	    			throw new CollectionNotFoundException(renamedCollection.getCollection_id(), "Collection not found!");
	    		}
	    		
	    		return true;
	    	} else {
	    		return false;
	    	}
	    }
	    
	    @RequestMapping(path="/all/{user_id}", method=RequestMethod.GET)
	    public List<Collection> getAllCollectionsForUser(@PathVariable Long user_id) throws CollectionNotFoundException {
	    	List<Collection> collections = null;
	    	
	    	if (authProvider.getCurrentUser() != null && authProvider.getCurrentUser().getId() == user_id) {
	    		collections = collectionDao.getCollectionsByUserId(user_id);
	    	} else {
	    		collections = collectionDao.getAllPublicCollectionsForUserId(user_id);
	    	}
	    	
	    	if(collections != null) {
	    		return collections;
	    	} else {
	    		throw new CollectionNotFoundException(0L, "Collections not found!");
	    	}
	    }
	    
	    @GetMapping("/all")
	    public List<Collection> getAllPublicCollections() throws CollectionNotFoundException {
	    	List<Collection> collections = collectionDao.getAllPublicCollections();
	    	if (collections != null) {
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
	    	if (authProvider.getCurrentUser() != null) {
		    	if(authProvider.getCurrentUser().getRole().equals("standard") && collectionDao.getCollectionsByUserId(authProvider.getCurrentUser().getId()).size() >= 1) {
		    		throw new CollectionCreationException("Your Account Has Reached It's Collection Limit!");
	
		    	}
		    	collection.setUser_id(authProvider.getCurrentUser().getId());
		    	return collectionDao.saveCollection(collection.getUser_id(), collection.getCollection_name(), collection.isPublic_bool());
	    	} else {
	    		throw new CollectionCreationException("You don't have access.");
	    	}
	    }
	    
	    
	    @RequestMapping(path="/add", method=RequestMethod.POST)
	    public void addComic(@Valid @RequestBody ComicCollection comicCollection, BindingResult result) throws CollectionNotFoundException {
	    	if(authProvider.getCurrentUser() != null && authProvider.getCurrentUser().getId() == collectionDao.findById(comicCollection.getCollection_id()).getUser_id()) {
		    	if(result.hasErrors()) {
		            String errorMessages = "";
		            for(ObjectError error : result.getAllErrors()) {
		                errorMessages += error.getDefaultMessage() + "\n";
		            }
		            throw new CollectionNotFoundException(comicCollection.getCollection_id(), errorMessages);
		    	}
		    	collectionDao.addComicToCollection(comicCollection.getCollection_id(), comicCollection.getComic_id());
	    	} else {
	    		throw new CollectionNotFoundException(0L, "You don't have access.");
	    	}
	    }
}