package com.spring.coffee.dao;

import java.util.List;

import com.spring.coffee.model.Attribute;

public interface AttributeDao {

	List<Attribute> findAll();

	Attribute findByName(String name);

	Attribute findById(int id);

	void delete(int id);
}
