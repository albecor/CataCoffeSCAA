package com.spring.coffee.service;

import com.spring.coffee.model.PasswordResetToken;

public interface PasswordResetTokenService {

	/**
	 * insert token for to reset password in the database
	 * 
	 * @param user
	 * @param token
	 */
	void insert(PasswordResetToken passwordResetToken);

	/**
	 * select token object by token data in the database
	 * 
	 * @param token
	 * @return PasswordResetToken object
	 */
	PasswordResetToken find(String token);

	/**
	 * delete token for reset password in the database
	 * 
	 * @param passwordResetToken
	 */
	void delete(int id);

	/**
	 * delete token for reset password in the database
	 * 
	 * @param passwordResetToken
	 */
	void deleteByUser(String username);

	void deleteExpiredPasswordResetToken();

	String validatePasswordResetToken(Integer id, String token);

}
