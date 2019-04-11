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
	public void changeCollectionName(long collection_id, String newCollection_name) {

		jdbcTemplate.update("UPDATE collections SET collection_name=? WHERE collection_id=?",
                newCollection_name, collection_id);
	}

	@Override
	public List<Collection> getCollectionByUsername(String username) {
		List<Collection> collections = new ArrayList<Collection>();
        String sqlSelectUserCollections = "SELECT collection_id FROM user_collection WHERE user_id=?";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectUserCollections);

        while(results.next()) {
            Collection collection = mapResultToCollection(results);
            collections.add(collection);
        }

        return collections;
	}

	
	private Collection mapResultToCollection(SqlRowSet results) {
		Collection collection = new Collection();
		collection.setUser_id(results.getLong("user_id"));
		collection.setCollection_name(results.getString("collection_name"));
		collection.setPublic_bool(results.getBoolean("public_bool"));
        return collection;
    }



	@Override
	public Collection findById(long id) {
		String sql = "SELECT * FROM collections WHERE collection_id = ?";
		return jdbcTemplate.queryForObject(sql, new  CollectionMapper(), id);
	}
	
	
	private static final class CollectionMapper implements RowMapper<Collection>{
		public Collection mapRow(ResultSet rs, int rowNum) throws SQLException {
			Collection collection = new Collection();
			collection.setCollection_id(rs.getLong("collection_id"));
			collection.setCollection_name(rs.getString("collection_name"));
			collection.setPublic_bool(rs.getBoolean("public_bool"));
			return collection;
		}
	}

	
	

	@Override
	public ComicCollection addComicToCollection(long collection_id, long comic_id) {
		ComicCollection comicCollection = new ComicCollection();
		String sqlComicExists = "SELECT comic_id FROM comic WHERE comic_id = ?";
		if (jdbcTemplate.queryForRowSet(sqlComicExists, comic_id).next() != true) {
			String sqlInsertComicId = "INSERT INTO comic(comic_id) VALUES (?)";
			jdbcTemplate.update(sqlInsertComicId, comic_id);
					
		}
		
		String sql = "INSERT INTO comic_collection(comic_id, collection_id) VALUES (?, ?)";
		jdbcTemplate.update(sql, comic_id, collection_id);
		comicCollection.setCollection_id(collection_id);
		comicCollection.setComic_id(comic_id);
		return comicCollection;
	}
}
