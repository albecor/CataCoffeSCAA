package com.spring.coffee.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.spring.coffee.model.Sample;

@Transactional
@Repository("sampleDao")
public class SampleDaoImpl extends AbstractDao<Integer, Sample> implements SampleDao {

	@Override
	public Sample findById(int id) {
		Sample sample = getByKey(id);
		if (sample != null) {
			Hibernate.initialize(sample.getTestses());
		}
		return sample;
	}

	@Override
	public Sample findByCode(String code) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("code", code));
		Sample sample = (Sample) crit.uniqueResult();
		return sample;
	}

	@Override
	public void save(Sample sample) {
		persist(sample);
	}

	@Override
	public void deleteById(int id) {

		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("id", id));
		Sample sample = (Sample) crit.uniqueResult();
		delete(sample);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Sample> findAll() {
		Criteria criteria = createEntityCriteria().addOrder(Order.desc("id"));
		criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);// To
																					// avoid
		// duplicates.
		return criteria.list();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.dao.SampleDao#selectSamplesWithoutPanel()
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Sample> selectSamplesWithoutPanel() {
		Criteria criteria = createEntityCriteria().add(Restrictions.isEmpty("testses"));
		return criteria.list();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.dao.SampleDao#selectSampleByPanel(java.lang.Integer)
	 */
	@Override
	public List<Sample> samplesByPanel(Integer panel) {
		Criteria criteria = createEntityCriteria().createCriteria("testses").add(Restrictions.eq("panel.id", panel));
		criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);// To
																					// avoid
		// duplicates.
		@SuppressWarnings("unchecked")
		List<Sample> samples = criteria.list();
		return samples;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.dao.SampleDao#findByTestId(java.lang.Integer)
	 */
	@Override
	public Sample findByTestId(Integer id) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("test.id", id));

		return (Sample) crit.uniqueResult();
	}

}
