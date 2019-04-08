package com.techelevator.controller;

import javax.validation.Valid;

import com.techelevator.authentication.AuthProvider;
import com.techelevator.authentication.JwtTokenHandler;
import com.techelevator.authentication.RegistrationResult;
import com.techelevator.authentication.UnauthorizedException;
import com.techelevator.authentication.UserCreationException;
import com.techelevator.model.JdbcUserDao;
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
public class AccountController {
    @Autowired
    private AuthProvider auth;

    @Autowired
    private JwtTokenHandler tokenHandler;
    
    @Autowired
    private JdbcUserDao userDao;

    @PostMapping("/login")
    public String login(@RequestBody User user) throws UnauthorizedException {
        if(auth.signIn(user.getUsername(), user.getPassword())) {
            User currentUser = auth.getCurrentUser();
            return tokenHandler.createToken(user.getUsername(), currentUser.getRole());
        } else {
            throw new UnauthorizedException();
        }
    }



    @PostMapping("/register")
    public RegistrationResult register(@Valid @RequestBody User user, BindingResult result) {
    	RegistrationResult registrationResult = new RegistrationResult();
    	if(result.hasErrors()) {
            for(ObjectError error : result.getAllErrors()) {
                registrationResult.addError(error.getDefaultMessage());
            }
        }
    	else {
    		auth.register(user.getUsername(), user.getPassword(), user.getRole(), user.getEmail(), user.getDateOfBirth());
    		System.out.println(user.getUsername());
    		registrationResult.setSuccess(true);
    	}
    	return registrationResult;
    }
    
    @RequestMapping(path="/user?user_id={id}", method=RequestMethod.GET)
    public User getUser(@PathVariable Long id) throws UserNotFoundException {
    	User user = userDao.getUserById(id);
    	if(user != null && user.getId() == auth.getCurrentUser().getId()) {
    		return user;
    	} else {
    		throw new UserNotFoundException(id, "User not found!");
    	}
    	
    }

}