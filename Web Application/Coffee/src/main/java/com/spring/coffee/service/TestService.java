package com.spring.coffee.service;

import java.util.List;

import com.spring.coffee.model.Test;

public interface TestService {

	Test findById(int id);

	void save(Test test);

	void update(Test test);

	void deleteById(int id);

	List<Test> findStartedByUser(Integer id);

	List<Test> findEndedByUser();

	List<Test> findAll();

}
