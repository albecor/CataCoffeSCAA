package com.spring.coffee.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.spring.coffee.model.Tests;

@Repository("testsDao")
public class TestsDaoImpl extends AbstractDao<Integer, Tests> implements TestsDao {

	@Override
	public void save(Tests tests) {
		persist(tests);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Tests> findStartedByUser(Integer id) {
		Criteria criteria = createEntityCriteria().add(Restrictions.eq("user.id", id)).createCriteria("test")
				.add(Restrictions.eq("finished", (byte) 0));
		return criteria.list();
	}

	@Override
	public Tests findByTest(Integer id) {
		Criteria criteria = createEntityCriteria().add(Restrictions.eq("id.testId", id));
		return (Tests) criteria.uniqueResult();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Tests> findTestBySample(Integer id) {
		Criteria criteria = createEntityCriteria().add(Restrictions.eq("id.sampleId", id)).createCriteria("test")
				.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
		return criteria.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Tests> findAllBySample(Integer id) {
		Criteria criteria = createEntityCriteria().add(Restrictions.eq("id.sampleId", id)).createCriteria("user")
				.createCriteria("test").createCriteria("sample");
		return criteria.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean TestFinalizedBySample(Integer id) { // by muestra
		Criteria criteria = createEntityCriteria().add(Restrictions.eq("id.sampleId", id)).createCriteria("test")
				.add(Restrictions.eq("finished", (byte) 0));

		boolean finalized = false;
		if (((List<Tests>) criteria.list()).isEmpty()) {
			finalized = true;
		}

		return finalized;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Tests> findUsersBySample(Integer id) {
		Criteria criteria = createEntityCriteria().add(Restrictions.eq("id.sampleId", id)).createCriteria("user")
				.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
		return criteria.list();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.dao.TestsDao#findStarted(java.lang.Integer,
	 * java.lang.Integer)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Tests> findStarted(Integer user_id, Integer panel_id) {
		Criteria criteria = createEntityCriteria().add(Restrictions.eq("user.id", user_id))
				.add(Restrictions.eq("panel.id", panel_id)).createCriteria("test")
				.add(Restrictions.eq("finished", (byte) 0))
				.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
		return criteria.list();
	}

}
