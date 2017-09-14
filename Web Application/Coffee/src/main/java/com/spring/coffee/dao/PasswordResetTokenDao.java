package com.spring.coffee.dao;

import com.spring.coffee.model.PasswordResetToken;

public interface PasswordResetTokenDao {

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
	 * select token object by username data in the database
	 * 
	 * @param username
	 * @return PasswordResetToken object
	 */
	PasswordResetToken findByUser(String username);

	/**
	 * delete token for reset password in the database
	 * 
	 * @param passwordResetToken
	 */
	void delete(int id);

	void deleteExpiredPasswordResetToken();

	PasswordResetToken findByToken(String token);

}
