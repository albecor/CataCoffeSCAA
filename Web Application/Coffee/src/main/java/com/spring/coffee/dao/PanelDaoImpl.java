package com.spring.coffee.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.spring.coffee.model.Panel;

@Repository("panelDao")
public class PanelDaoImpl extends AbstractDao<Integer, Panel> implements PanelDao {

	// static final Logger logger = LoggerFactory.getLogger(PanelDaoImpl.class);

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.dao.PanelDao#findAll()
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Panel> findAll() {
		Criteria criteria = createEntityCriteria();
		criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);// To
																					// avoid
		// duplicates.
		List<Panel> panels = criteria.list();
		return panels;

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.dao.PanelDao#findById(java.lang.Integer)
	 */
	@Override
	public Panel findById(Integer id) {
		Panel panel = getByKey(id);
		return panel;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.dao.PanelDao#delete(java.lang.Integer)
	 */
	@Override
	public void delete(Integer id) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("id", id));
		Panel panel = (Panel) crit.uniqueResult();
		delete(panel);

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.dao.PanelDao#save(com.spring.coffee.model.Panel)
	 */
	@Override
	public void save(Panel panel) {
		persist(panel);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.dao.PanelDao#unauthorized()
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Panel> unauthorized() {
		Criteria criteria = createEntityCriteria().add(Restrictions.isNull("authorizationDate"));
		criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
		return criteria.list();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.dao.PanelDao#authorizedByUserId(java.lang.Integer)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Panel> authorizedByUserId(Integer userId) {

		Criteria criteria = createEntityCriteria().add(Restrictions.isNotNull("authorizationDate"))
				.createCriteria("testses").add(Restrictions.eq("user.id", userId)).createCriteria("test")
				.add(Restrictions.eq("finished", (byte) 0));
		criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
		return criteria.list();
	}

}
