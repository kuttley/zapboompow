package com.techelevator.model;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import org.springframework.jdbc.core.RowMapper;

@Component
public class JdbcComicDao implements ComicDao {

	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public JdbcComicDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	@Override
	public Comic saveComic(long comic_id, String comic_image, String comic_title, String comic_description,
			Date comic_release_date, String comic_creators) {
		String sql = "INSERT INTO comic(comic_id, comic_image, comic_title, comic_description, comic_release_date, comic_creators) VALUES (?, ?, ?, ?, ?, ?) RETURNING *";
		Comic newComic = jdbcTemplate.queryForObject(sql, new ComicMapper(), comic_id, comic_image, comic_title, comic_description, comic_release_date, comic_creators);
		
		return newComic;
	}

	@Override
	public Comic getComicById(long comic_id) {
		List<Comic> comicResult = jdbcTemplate.query("SELECT * FROM comic WHERE comic_id = ?", new ComicMapper(), comic_id);
		if (comicResult.size() > 0) {
			return comicResult.get(0);
		}
		return null;
	}

	@Override
	public Comic getComicByTitle(String comic_title) {
		return jdbcTemplate.queryForObject("SELECT * FROM comic WHERE comic_title = ?", new ComicMapper(), comic_title);
	}

	@Override
	public List<Comic> getComicsByCreator(String comic_creator) {
		return jdbcTemplate.query("SELECT * FROM comic WHERE ? = ANY(comic_creators)", new ComicMapper(), comic_creator);
	}
	
	private final class ComicMapper implements RowMapper<Comic>{
		public Comic mapRow(ResultSet rs, int rowNum) throws SQLException {
			Comic comic = new Comic();
			comic.setComic_id(rs.getLong("comic_id"));
			comic.setComic_image(rs.getString("comic_image"));
			comic.setComic_title(rs.getString("comic_title"));
			comic.setComic_description(rs.getString("comic_description"));
			comic.setComic_release_date(rs.getDate("comic_release_date"));
			comic.setComic_creators(rs.getString("comic_creators"));
			
			return comic;
		}
	}

}
