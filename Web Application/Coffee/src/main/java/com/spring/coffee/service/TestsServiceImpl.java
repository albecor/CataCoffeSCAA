package com.spring.coffee.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.coffee.dao.TestsDao;
import com.spring.coffee.model.Tests;

@Service("testsService")
@Transactional
public class TestsServiceImpl implements TestsService {

	@Autowired
	TestsDao dao;

	@Override
	public void save(Tests tests) {
		dao.save(tests);
	}

	@Override
	public List<Tests> findStartedByUser(Integer id) {
		return dao.findStartedByUser(id);
	}

	@Override
	public Tests findByTest(Integer id) {
		return dao.findByTest(id);
	}

	@Override
	public List<Tests> findAllBySample(Integer id) {

		return dao.findAllBySample(id);
	}

	@Override
	public boolean TestFinalizedBySample(Integer id) {
		return dao.TestFinalizedBySample(id);
	}

	@Override
	public List<Tests> findTestBySample(Integer id) {
		return dao.findTestBySample(id);
	}

	@Override
	public List<Tests> findUsersBySample(Integer id) {
		return dao.findUsersBySample(id);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.service.TestsService#findStarted(java.lang.Integer,
	 * java.lang.Integer)
	 */
	@Override
	public List<Tests> findStarted(Integer user_id, Integer panel_id) {

		return dao.findStarted(user_id, panel_id);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.spring.coffee.service.TestsService#delete(com.spring.coffee.model.Tests)
	 */
	@Override
	public void delete(Tests tests) {
		dao.delete(tests);
	}

}
