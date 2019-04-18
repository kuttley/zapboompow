package com.techelevator.model;

import java.util.List;

import javax.validation.constraints.AssertTrue;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;

/**
 * User
 */
public class User {
	
	@Size(min=6, max=30, message="Username must be between 6 and 30 characters.")
    @NotBlank(message="Username is required")
    private String username;
   
    @NotBlank(message="Email is required")
    @Email(message="Not a valid email")
    private String email;
    
    @NotBlank(message="Role is required")
    private String role;
    private long id;
    
    private String[] favoriteCollections;

    @Size(min=4, max=32, message="Password must be between 4 and 32 characters.")
	@NotBlank(message="Password is required")
    private String password;
    private String confirmPassword;

    @AssertTrue(message = "Passwords must match")
    public boolean isPasswordMatching() {
        if (password != null) {
            return password.equals(confirmPassword);
        }
        return true;
    }

    public String getPassword() {
        return password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    /**
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * @return the id
     */
    public long getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(long id) {
        this.id = id;
    }

    /**
     * @return the role
     */
    public String getRole() {
        return role;
    }

    /**
     * @param role the role to set
     */
    public void setRole(String role) {
        this.role = role;
    }

    /**
     * @param username the username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }
    public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String[] getFavoriteCollections() {
		return favoriteCollections;
	}

	public void setFavoriteCollections(String[] favoriteCollections) {
		this.favoriteCollections = favoriteCollections;
	}

	
	
}