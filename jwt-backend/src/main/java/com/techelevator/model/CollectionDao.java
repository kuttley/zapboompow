package com.techelevator.model;

import java.util.List;

public interface CollectionDao {
	
	public Collection saveCollection(long user_id, String collection_name, Boolean public_bool);
	
    public boolean changeCollectionName(long collection_id, String newCollection_name);
    
    public List<Collection> getCollectionsByUserId(long user_id);

    public Collection findById(long collection_id);
    
    public void addComicToCollection(long collection_id, long comic_id);
    
    public long[] getComicsInCollectionByCollectionId(long collection_id);

	public List<Collection> getAllPublicCollections();

	public List<Collection> getAllPublicCollectionsForUserId(long user_id);

	public boolean deleteCollection(long collection_id);

}
