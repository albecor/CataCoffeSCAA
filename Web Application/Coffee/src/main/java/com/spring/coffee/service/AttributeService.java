package com.spring.coffee.service;

import java.util.List;

import com.spring.coffee.model.Attribute;

public interface AttributeService {

	Attribute findById(int id);

	Attribute findByName(String name);

	List<Attribute> findAll();

	void delete(int id);
}
