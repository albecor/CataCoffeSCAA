package com.spring.coffee.service;

import java.util.List;

import com.spring.coffee.model.Panel;

public interface PanelService {

	List<Panel> findAll();

	List<Panel> unauthorized();

	List<Panel> authorizedByUserId(Integer userId);

	Panel findById(Integer id);

	void delete(Integer id);

	void save(Panel panel);

	void update(Panel panel);

}
