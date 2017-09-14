package com.spring.coffee.service;

import java.util.List;

import com.spring.coffee.model.Tests;

public interface TestsService {

	void save(Tests tests);

	void delete(Tests tests);

	List<Tests> findStartedByUser(Integer id);

	List<Tests> findStarted(Integer user_id, Integer panel_id);

	Tests findByTest(Integer id);

	List<Tests> findAllBySample(Integer id);

	boolean TestFinalizedBySample(Integer id);

	List<Tests> findTestBySample(Integer id);

	List<Tests> findUsersBySample(Integer id);

}
