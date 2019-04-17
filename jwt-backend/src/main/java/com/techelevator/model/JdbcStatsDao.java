package com.techelevator.model;

import java.math.BigInteger;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;


@Component
public class JdbcStatsDao implements StatsDao {
	
    private JdbcTemplate jdbcTemplate;

    @Autowired
	public JdbcStatsDao(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
    
    @Override
    public Stats getAllStats() {
    	Stats stats = new Stats();
		String sqlAllCollections = "SELECT COUNT (*) FROM collections";
		String sqlPublicCollections = "SELECT COUNT (*) FROM collections WHERE public_bool = 'true'";
		String sqlComicsCount = "SELECT COUNT (*) FROM comic";
		String sqlUsersCount = "SELECT COUNT (*) FROM users";
		String sqlPremiumUsersCount = "SELECT COUNT (*) FROM users WHERE role = 'premium'";
					

	
    	stats.setCollectionsCount(jdbcTemplate.queryForObject(sqlAllCollections, Integer.class));
    	stats.setPublicCollectionsCount(jdbcTemplate.queryForObject(sqlPublicCollections, Integer.class));
    	stats.setComicsCount(jdbcTemplate.queryForObject(sqlComicsCount, Integer.class));
    	stats.setUsersCount(jdbcTemplate.queryForObject(sqlUsersCount, Integer.class));
    	stats.setPremiumUsersCount(jdbcTemplate.queryForObject(sqlPremiumUsersCount, Integer.class));
    	
    	return stats;


    }
    
}
