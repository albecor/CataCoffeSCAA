package com.spring.coffee.dao;

import java.util.List;

import com.spring.coffee.model.User;

public interface UserDao {

	User findById(int id);

	User findByNdivalue(String ndivalue);

	void save(User user);

	void deleteById(int id);

	void deleteByUsername(String username);

	List<User> findAllUsers();

	List<User> findUsersByRole(String type);

	Integer countAdministrators();

}
