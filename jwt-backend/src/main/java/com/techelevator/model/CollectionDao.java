package com.techelevator.model;

import java.util.List;

public interface CollectionDao {
	
	public Collection saveCollection(Collection collection);
	
    public void changeCollectionName(Long id, String newCollection_name);
    
    public List<Collection> getCollectionByUsername(String username);

    public Collection findById(Long id);

}
