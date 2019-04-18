package com.techelevator.model;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.bouncycastle.util.encoders.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.techelevator.authentication.PasswordHasher;

@Component
public class JdbcUserDao implements UserDao {

    private JdbcTemplate jdbcTemplate;
    private PasswordHasher passwordHasher;

    /**
     * Create a new user dao with the supplied data source and the password hasher
     * that will salt and hash all the passwords for users.
     *
     * @param dataSource an SQL data source
     * @param passwordHasher an object to salt and hash passwords
     */
    @Autowired
    public JdbcUserDao(DataSource dataSource, PasswordHasher passwordHasher) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
        this.passwordHasher = passwordHasher;
    }

    /**
     * Save a new user to the database. The password that is passed in will be
     * salted and hashed before being saved. The original password is never
     * stored in the system. We will never have any idea what it is!
     *
     * @param userName the user name to give the new user
     * @param password the user's password
     * @param role the user's role
     * @return the new user
     */
    @Override
    public User saveUser(String userName, String password, String role, String email) {
        byte[] salt = passwordHasher.generateRandomSalt();
        String hashedPassword = passwordHasher.computeHash(password, salt);
        String saltString = new String(Base64.encode(salt));
        long newId = jdbcTemplate.queryForObject("INSERT INTO users(username, password, salt, role, email) VALUES (?, ?, ?, ?, ?) RETURNING user_id", Long.class, userName,
                hashedPassword, saltString, role, email);

        User newUser = new User();
        newUser.setId(newId);
        newUser.setUsername(userName);
        newUser.setRole(role);
        newUser.setEmail(email);
       

        return newUser;
    }

    @Override
    public void changePassword(User user, String newPassword) {
        byte[] salt = passwordHasher.generateRandomSalt();
        String hashedPassword = passwordHasher.computeHash(newPassword, salt);
        String saltString = new String(Base64.encode(salt));

        jdbcTemplate.update("UPDATE users SET password=?, salt=? WHERE user_id=?",
                hashedPassword, saltString, user.getId());
    }

    /**
     * Look for a user with the given username and password. Since we don't
     * know the password, we will have to get the user's salt from the database,
     * hash the password, and compare that against the hash in the database.
     *
     * @param userName the user name of the user we are checking
     * @param password the password of the user we are checking
     * @return true if the user is found and their password matches
     */
    @Override
    public User getValidUserWithPassword(String userName, String password) {
        String sqlSearchForUser = "SELECT * FROM users WHERE UPPER(username) = ?";

        SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSearchForUser, userName.toUpperCase());
        if (results.next()) {
            String storedSalt = results.getString("salt");
            String storedPassword = results.getString("password");
            String hashedPassword = passwordHasher.computeHash(password, Base64.decode(storedSalt));
            if(storedPassword.equals(hashedPassword)) {
                return mapResultToUser(results);
            } else {
                return null;
            }
        } else {
            return null;
        }
    }

    /**
     * Get all of the users from the database.
     * @return a List of user objects
     */
    @Override
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<User>();
        String sqlSelectAllUsers = "SELECT user_id, username, role, favorite_collections FROM users";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectAllUsers);

        while(results.next()) {
            User user = mapResultToUser(results);
            users.add(user);
        }

        return users;
    }

    private User mapResultToUser(SqlRowSet results) {
        User user = new User();
        user.setId(results.getLong("user_id"));
        user.setUsername(results.getString("username"));
        user.setRole(results.getString("role"));
        user.setEmail(results.getString("email"));
        
        String userFavorites = "SELECT collection_id FROM user_favorites_collections WHERE user_id = ?";
        SqlRowSet favoritesResults = jdbcTemplate.queryForRowSet(userFavorites, user.getId());
        List<String> favs = new ArrayList<>();
        while (favoritesResults.next()) {
        	favs.add(favoritesResults.getString("collection_id"));
        }
        
        user.setFavoriteCollections(favs.toArray(new String[favs.size()]));
        return user;
    }

    @Override
    public User getUserByUsername(String username) {
        String sqlSelectUserByUsername = "SELECT user_id, username, role, email, favorite_collections FROM users WHERE username = ?";
        SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectUserByUsername, username);

        if(results.next()) {
            return mapResultToUser(results);
        } else {
            return null;
        }
    }
    
    @Override
    public User getUserByEmail(String email) {
    	String sqlSelectUserByEmail = "SELECT user_id, username, role, email, favorite_collections FROM users WHERE email = ?";
    	SqlRowSet results = jdbcTemplate.queryForRowSet(sqlSelectUserByEmail, email);
    	
    	if (results.next()) {
    		return mapResultToUser(results);
    	} else {
    		return null;
    	}
    }

	@Override
	public User getOtherUserById(Long id) {
		String sql = "SELECT username, favorite_collections FROM users WHERE user_id = ?";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sql, id);
		if(results.next()) {
			User otherUser = new User();

			otherUser.setUsername(results.getString("username"));
	        
	        String userFavorites = "SELECT collection_id FROM user_favorites_collections WHERE user_id = ?";
	        SqlRowSet favoritesResults = jdbcTemplate.queryForRowSet(userFavorites, id);
	        List<String> favs = new ArrayList<>();
	        while (favoritesResults.next()) {
	        	favs.add(favoritesResults.getString("collection_id"));
	        }
	        
	        otherUser.setFavoriteCollections(favs.toArray(new String[favs.size()]));
			
			otherUser.setId(id);
			return otherUser;
		} else {
			return null;
			}
	    }

	@Override
	public void upgradeUserToPremium(Long id) {
		String sql = "UPDATE users SET role = 'premium' WHERE user_id = ?";
		jdbcTemplate.update(sql, id);
	}
	
	@Override
	public void addToFavoriteCollections(Long user_id, Long collection_id) {
		String sql = "INSERT INTO user_favorites_collections(user_id, collection_id) VALUES (?, ?)";
		String updateCollectionSql = "UPDATE collections SET num_favorites = num_favorites+1 WHERE collection_id = ?";
		jdbcTemplate.update(updateCollectionSql, collection_id);
		jdbcTemplate.update(sql, user_id, collection_id);
	}
	
	@Override
	public List<String> getUserFavorites(Long user_id) {
		String sql = "SELECT collection_id FROM user_favorites_collections WHERE user_id = ?";
		SqlRowSet favs = jdbcTemplate.queryForRowSet(sql, user_id);
		List<String> results = new ArrayList<>();
		while (favs.next()) {
			results.add(favs.getString("collection_id"));
		}
		return results;
	}
	
	@Override
	public void removeFromUserFavorites(Long user_id, Long collection_id) {
		String sql = "DELETE FROM user_favorites_collections WHERE user_id = ? AND collection_id = ?";
		String updateCollectionSql = "UPDATE collections SET num_favorites = num_favorites-1 WHERE collection_id = ?";
		jdbcTemplate.update(updateCollectionSql, collection_id);
		jdbcTemplate.update(sql, user_id, collection_id);
	}
}
