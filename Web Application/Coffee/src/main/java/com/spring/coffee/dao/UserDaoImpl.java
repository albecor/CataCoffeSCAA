package com.spring.coffee.dao;

import java.math.BigInteger;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.spring.coffee.model.User;

@Repository("userDao")
public class UserDaoImpl extends AbstractDao<Integer, User> implements UserDao {

	// static final Logger logger = LoggerFactory.getLogger(UserDaoImpl.class);

	@Override
	public User findById(int id) {
		User user = getByKey(id);
		if (user != null) {
			Hibernate.initialize(user.getRoles());
		}
		return user;
	}

	@Override
	public User findByNdivalue(String username) {
		// logger.info("username : {}", username);
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("username", username));
		User user = (User) crit.uniqueResult();
		if (user != null) {
			Hibernate.initialize(user.getRoles());
		}
		return user;
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<User> findAllUsers() {
		Criteria criteria = createEntityCriteria().addOrder(Order.asc("firstName"));
		criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);// To
																					// avoid
		// duplicates.
		List<User> users = criteria.list();

		// No need to fetch userProfiles since we are not showing them on list
		// page. Let them lazy load.
		// Uncomment below lines for eagerly fetching of userProfiles if you
		// want.
		/*
		 * for(User user : users){ Hibernate.initialize(user.getUserProfiles()); }
		 */
		return users;
	}

	@Override
	public void save(User user) {
		persist(user);
	}

	@Override
	public void deleteById(int id) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("id", id));
		User user = (User) crit.uniqueResult();
		delete(user);
	}

	@Override
	public List<User> findUsersByRole(String type) {
		Criteria criteria = createEntityCriteria().addOrder(Order.asc("firstName")).createCriteria("roles")
				.add(Restrictions.eq("type", type));
		criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);// To
																					// avoid
		// duplicates.
		@SuppressWarnings("unchecked")
		List<User> users = criteria.list();
		return users;
	}

	@Override
	public void deleteByUsername(String username) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("username", username));
		User user = (User) crit.uniqueResult();
		delete(user);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.dao.UserDao#countAdministrators()
	 */
	@Override
	public Integer countAdministrators() {
		int count = ((BigInteger) getSession().createSQLQuery("SELECT COUNT(*) AS count FROM roles WHERE role_id = 2")
				.uniqueResult()).intValue();
		return count;
	}

}
