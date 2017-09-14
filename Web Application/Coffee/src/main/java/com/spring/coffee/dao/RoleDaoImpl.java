package com.spring.coffee.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.spring.coffee.model.Role;

@Repository("userProfileDao")
public class RoleDaoImpl extends AbstractDao<Integer, Role> implements RoleDao {

	@Override
	public Role selectById(int id) {
		return getByKey(id);
	}

	@Override
	public Role selectByType(String type) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("type", type));
		return (Role) crit.uniqueResult();
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Role> selectAll() {
		Criteria crit = createEntityCriteria();
		crit.addOrder(Order.asc("type"));
		return crit.list();
	}

	@Override
	public void delete(int id) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("id", id));
		Role role = (Role) crit.uniqueResult();
		delete(role);

	}

}
