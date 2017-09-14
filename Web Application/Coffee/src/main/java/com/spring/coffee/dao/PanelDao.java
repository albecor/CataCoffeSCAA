package com.spring.coffee.dao;

import java.util.List;

import com.spring.coffee.model.Panel;

public interface PanelDao {

	List<Panel> findAll();

	List<Panel> unauthorized();

	List<Panel> authorizedByUserId(Integer userId);

	Panel findById(Integer id);

	void delete(Integer id);

	void update(Panel panel);

	void save(Panel panel);
}
