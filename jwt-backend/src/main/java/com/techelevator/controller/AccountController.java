package com.techelevator.controller;

import java.util.List;

import javax.validation.Valid;

import com.techelevator.authentication.AuthProvider;
import com.techelevator.authentication.JwtTokenHandler;
import com.techelevator.authentication.RegistrationResult;
import com.techelevator.authentication.UnauthorizedException;
import com.techelevator.authentication.UserCreationException;
import com.techelevator.model.CollectionFavorite;
import com.techelevator.model.JdbcStatsDao;
import com.techelevator.model.JdbcUserDao;
import com.techelevator.model.Stats;
import com.techelevator.model.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

/**
 * AccountController
 */
@RestController
@CrossOrigin
public class AccountController {
    @Autowired
    private AuthProvider auth;

    @Autowired
    private JwtTokenHandler tokenHandler;
    
    @Autowired
    private JdbcUserDao userDao;
    
    @Autowired
    private JdbcStatsDao statsDao;

    @PostMapping("/login")
    public String login(@RequestBody User user) throws UnauthorizedException {
        if(auth.signIn(user.getUsername(), user.getPassword())) {
            User currentUser = auth.getCurrentUser();
            return tokenHandler.createToken(user.getUsername(), currentUser.getRole(), currentUser.getId());
        } else {
            throw new UnauthorizedException();
        }
    }

    @PostMapping("/logout")
    public void logout() throws UnauthorizedException {
    	auth.logOff();
    }

    @PostMapping("/register")
    public RegistrationResult register(@Valid @RequestBody User user, BindingResult result) {
    	RegistrationResult registrationResult = new RegistrationResult();
		if (userDao.getUserByUsername(user.getUsername()) != null) {
        	result.addError(new ObjectError("username", "There is already a user account with that name."));
        } 
		if (userDao.getUserByEmail(user.getEmail()) != null) {
        	result.addError(new ObjectError("email", "There is already a user account with that email."));
		}
		
		if(result.hasErrors()) {
            for(ObjectError error : result.getAllErrors()) {
                registrationResult.addError(error.getDefaultMessage());
            }
        }
    	else {
    		auth.register(user.getUsername(), user.getPassword(), user.getRole(), user.getEmail());
    		registrationResult.setSuccess(true);
    	}
    	return registrationResult;
    }
    
    @RequestMapping(path="/user/{id}", method=RequestMethod.GET)
    public User getUser(@PathVariable Long id) throws UserNotFoundException {
    	User currentUser = auth.getCurrentUser();
    	if (currentUser != null && currentUser.getId() == id) {
    		return currentUser;
    	}
    	else {
	    	User user = userDao.getOtherUserById(id);
	    	
	    	if(user != null ) {
	    		return user;
	    	} else {
	    		throw new UserNotFoundException(id, "User not found!");
	    	}
	    	
    	}
    }
    
    @PostMapping("/api/validate/email")
    public boolean userWithEmailExists(@RequestBody String email) {
    	User user = userDao.getUserByEmail(email);
    	
    	if (user != null) {
    		return true;
    	} else {
    		return false;
    	}
    }
    
    @PostMapping("/api/validate/username")
    public boolean userWithUsernameExists(@RequestBody String username) {
    	User user = userDao.getUserByUsername(username);
    	
    	if (user != null) {
    		return true;
    	} else {
    		return false;
    	}
    }

    @PostMapping("/upgrade")
    public String upgradeAccount(@RequestBody Long user_id) throws UnauthorizedException {
    	if (auth.getCurrentUser() != null && auth.getCurrentUser().getRole() != "premium" && auth.getCurrentUser().getId() == user_id) {
    		userDao.upgradeUserToPremium(user_id);
    		User upgradedUser = userDao.getOtherUserById(user_id);
            return tokenHandler.createToken(upgradedUser.getUsername(), upgradedUser.getRole(), upgradedUser.getId());
    	} else {
    		throw new UnauthorizedException();
    	}
    }
    
    @GetMapping("/stats")
    public Stats getAllStats() throws CollectionNotFoundException {
		return statsDao.getAllStats();
    }
    
    @PostMapping("/addToFavorites")
    public void addToFavorites(@RequestBody CollectionFavorite newFav) {
    	if (auth.getCurrentUser() != null && auth.getCurrentUser().getId() == newFav.getUser_id()) {
    		userDao.addToFavoriteCollections(newFav.getUser_id(), newFav.getCollection_id());
    	}
    }
    
    @GetMapping("/user/favorites/{id}")
    public List<String> getUserFavorites(@PathVariable Long id) {
    	return userDao.getUserFavorites(id);
    }
    
    @PostMapping("/removeFromFavorites")
    public void removeFromFavorites(@RequestBody CollectionFavorite fav) {
    	if (auth.getCurrentUser() != null && auth.getCurrentUser().getId() == fav.getUser_id()) {
    		userDao.removeFromUserFavorites(fav.getUser_id(), fav.getCollection_id());
    	}
    }

}