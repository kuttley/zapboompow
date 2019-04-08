package com.techelevator.controller;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(code=HttpStatus.BAD_REQUEST)
public class CollectionCreationException extends Exception {

	private static final long serialVersionUID = 9154702287751082647L;

	public CollectionCreationException(String messages) {
		super(messages);
	}

}
