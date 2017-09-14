package com.spring.coffee.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.coffee.dao.RoleDao;
import com.spring.coffee.model.Role;

@Service("userProfileService")
@Transactional
public class RoleServiceImpl implements RoleService {

	@Autowired
	RoleDao dao;

	@Override
	public Role findById(int id) {
		return dao.selectById(id);
	}

	@Override
	public Role findByType(String type) {
		return dao.selectByType(type);
	}

	@Override
	public List<Role> findAll() {
		return dao.selectAll();
	}

	@Override
	public void delete(int id) {
		dao.delete(id);
	}
}