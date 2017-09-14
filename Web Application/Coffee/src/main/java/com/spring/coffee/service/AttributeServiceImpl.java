package com.spring.coffee.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.coffee.dao.AttributeDao;
import com.spring.coffee.model.Attribute;

@Service("attributeService")
@Transactional
public class AttributeServiceImpl implements AttributeService {

	@Autowired
	AttributeDao dao;

	@Override
	public Attribute findById(int id) {
		return dao.findById(id);
	}

	@Override
	public Attribute findByName(String name) {
		return dao.findByName(name);
	}

	@Override
	public List<Attribute> findAll() {
		return dao.findAll();
	}

	@Override
	public void delete(int id) {
		dao.delete(id);
	}
}
