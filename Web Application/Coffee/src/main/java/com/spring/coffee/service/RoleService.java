package com.spring.coffee.service;

import java.util.List;

import com.spring.coffee.model.Role;

public interface RoleService {

	Role findById(int id);

	Role findByType(String type);

	List<Role> findAll();

	void delete(int id);

}
