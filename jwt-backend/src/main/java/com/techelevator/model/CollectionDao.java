package com.techelevator.model;

import java.util.List;

public interface CollectionDao {
	
	public Collection saveCollection(long user_id, String collection_name, Boolean public_bool);
	
    public void changeCollectionName(long collection_id, String newCollection_name);
    
    public List<Collection> getCollectionByUsername(String username);

    public Collection findById(long collection_id);

}
