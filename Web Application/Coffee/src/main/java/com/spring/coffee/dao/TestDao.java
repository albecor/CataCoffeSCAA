package com.spring.coffee.dao;

import java.util.List;

import com.spring.coffee.model.Test;

public interface TestDao {

	Test findById(int id);

	void save(Test test);

	void deleteById(int id);

	List<Test> findStartedByUser(Integer id);

	List<Test> findAll();

	List<Test> findEndedByUser();

}
