package com.spring.coffee.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.spring.coffee.model.Attribute;

@Repository("attributeDao")
public class AttributeDaoImpl extends AbstractDao<Integer, Attribute> implements AttributeDao {

	@Override
	public Attribute findById(int id) {
		return getByKey(id);
	}

	@Override
	public Attribute findByName(String name) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("name", name));
		return (Attribute) crit.uniqueResult();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Attribute> findAll() {
		Criteria crit = createEntityCriteria();
		crit.addOrder(Order.asc("id"));
		return crit.list();
	}

	@Override
	public void delete(int id) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("id", id));
		Attribute attribute = (Attribute) crit.uniqueResult();
		delete(attribute);
	}

}
