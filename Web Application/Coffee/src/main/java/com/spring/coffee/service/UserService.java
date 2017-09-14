package com.spring.coffee.service;

import java.util.List;

import com.spring.coffee.model.User;

public interface UserService {

	User selectById(int id);

	User selectByUsername(String username);

	void saveUser(User user);

	void updateUser(User user);

	void deleteUserById(int id);

	void deleteUserByUsername(String username);

	List<User> findAllUsers();

	boolean existUser(String username);

	List<User> findUsersByRole(String type);

	boolean existAdmin();

	Integer countAdministrators();

}