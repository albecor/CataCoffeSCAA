package com.spring.coffee.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.spring.coffee.model.Test;

@Repository("testDao")
public class TestDaoImpl extends AbstractDao<Integer, Test> implements TestDao {

	@Override
	public Test findById(int id) {
		Test test = getByKey(id);

		return test;
	}

	@Override
	public void save(Test test) {
		persist(test);
	}

	@Override
	public void deleteById(int id) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("id", id));
		Test test = (Test) crit.uniqueResult();
		delete(test);
	}

	@Override
	public List<Test> findStartedByUser(Integer id) {
		Criteria criteria = createEntityCriteria().addOrder(Order.asc("id")).add(Restrictions.eq("user_id", id))
				.createCriteria("tests").add(Restrictions.eq("user_id", id));

		// criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);//To
		// avoid duplicates.
		List<Test> tests = criteria.list();

		return tests;
	}

	@Override
	public List<Test> findEndedByUser() {
		// TODO Auto-generated method stub
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.dao.TestDao#findAll()
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Test> findAll() {
		Criteria criteria = createEntityCriteria().addOrder(Order.asc("id"));
		criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);// To
																					// avoid
		// duplicates.
		return criteria.list();
	}

}
