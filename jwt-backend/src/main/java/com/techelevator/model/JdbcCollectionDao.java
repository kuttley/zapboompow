package com.techelevator.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;


@Component
public class JdbcCollectionDao implements CollectionDao {

	private JdbcTemplate jdbcTemplate;

	@Autowired
	public JdbcCollectionDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);

	}
	
	

	@Override
	public Collection saveCollection(long user_id, String collection_name, Boolean public_bool) {
		
		
		long newId = jdbcTemplate.queryForObject("INSERT INTO collections(collection_name, public_bool, user_id) VALUES (?, ?, ?) RETURNING collection_id", Long.class, collection_name,
				public_bool, user_id);

        Collection newCollection = new Collection();
        newCollection.setCollection_id(newId);
        newCollection.setCollection_name(collection_name);
        newCollection.setPublic_bool(public_bool);
        newCollection.setUser_id(user_id);
       

        return newCollection;
	}

	@Override
	public boolean deleteCollection(long collection_id) {
		int result = jdbcTemplate.update("DELETE FROM comic_collection WHERE collection_id = ?", collection_id);
		result += jdbcTemplate.update("DELETE FROM collections WHERE collection_id = ?", collection_id);
		if (result > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	@Override
	public boolean changeCollectionName(long collection_id, String new_collection_name) {

		int result = jdbcTemplate.update("UPDATE collections SET collection_name=? WHERE collection_id=?",
                new_collection_name, collection_id);
		
		if (result > 0) {
			return true;
		} else {
			return false;
		}
 	}

	@Override
	public List<Collection> getCollectionsByUserId(long user_id) {
		List<Collection> collections = new ArrayList<Collection>();
        String sqlSelectUserCollections = "SELECT * FROM collections WHERE user_id=?";
        collections = jdbcTemplate.query(sqlSelectUserCollections, new CollectionMapper(), user_id);

        return collections;
	}
	

	@Override
	public List<Collection> getAllPublicCollectionsForUserId(long user_id) {
		String sqlSelectAllPublicCollections = "SELECT * FROM collections WHERE public_bool = 'true' AND user_id = ?";
		return jdbcTemplate.query(sqlSelectAllPublicCollections, new CollectionMapper(), user_id);
	}
	
	@Override
	public List<Collection> getAllPublicCollections() {
		String sqlSelectAllPublicCollections = "SELECT * FROM collections WHERE public_bool = 'true'";
		return jdbcTemplate.query(sqlSelectAllPublicCollections, new CollectionMapper());
	}

	@Override
	public Collection findById(long id) {
		String sql = "SELECT * FROM collections WHERE collection_id = ?";
		return jdbcTemplate.queryForObject(sql, new  CollectionMapper(), id);
	}
	

	@Override
	public void addComicToCollection(long collection_id, long comic_id) {
		String sqlComicExists = "SELECT comic_id FROM comic WHERE comic_id = ?";
		if (jdbcTemplate.queryForRowSet(sqlComicExists, comic_id).next() != true) {
			String sqlInsertComicId = "INSERT INTO comic(comic_id) VALUES (?)";
			jdbcTemplate.update(sqlInsertComicId, comic_id);
		}
		
		String sql = "INSERT INTO comic_collection(comic_id, collection_id) VALUES (?, ?)";
		jdbcTemplate.update(sql, comic_id, collection_id);
	}
	
	@Override
	public long[] getComicsInCollectionByCollectionId(long collection_id) {
		List<Long> comicIds = new ArrayList<Long>();
		
		String sql = "SELECT comic_id FROM comic_collection WHERE collection_id = ?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sql, collection_id);
		while (results.next()) {
			comicIds.add(results.getLong("comic_id"));
		}
		return comicIds.stream().mapToLong(l -> l).toArray();
	}
	
	private final class CollectionMapper implements RowMapper<Collection>{
		public Collection mapRow(ResultSet rs, int rowNum) throws SQLException {
			Collection collection = new Collection();
			collection.setUser_id(rs.getLong("user_id"));
			collection.setCollection_id(rs.getLong("collection_id"));
			collection.setCollection_name(rs.getString("collection_name"));
			collection.setPublic_bool(rs.getBoolean("public_bool"));
			
			long[] comicsInCollection = getComicsInCollectionByCollectionId(collection.getCollection_id());
			collection.setComic_ids_in_collection(comicsInCollection);
			
			return collection;
		}
	}
	
}
