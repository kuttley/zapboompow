package com.techelevator.controller;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(code=HttpStatus.BAD_REQUEST)
public class ComicAddException extends Exception {
	
	private static final long serialVersionUID = 9154702287751082647L;

	public ComicAddException(String messages) {
		super(messages);
	}
}
