package com.spring.coffee.dao;

import java.util.List;

import com.spring.coffee.model.Role;

public interface RoleDao {

	List<Role> selectAll();

	Role selectByType(String type);

	Role selectById(int id);

	void delete(int id);

}
