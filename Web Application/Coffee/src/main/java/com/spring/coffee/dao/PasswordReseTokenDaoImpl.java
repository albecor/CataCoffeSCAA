package com.spring.coffee.dao;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.spring.coffee.model.PasswordResetToken;

@Repository("passwordResetTokenDao")
public class PasswordReseTokenDaoImpl extends AbstractDao<Integer, PasswordResetToken>
		implements PasswordResetTokenDao {

	@Override
	public void insert(PasswordResetToken passwordResetToken) {
		persist(passwordResetToken);
	}

	@Override
	public void delete(int id) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("id", id));
		PasswordResetToken passwordResetToken = (PasswordResetToken) crit.uniqueResult();
		delete(passwordResetToken);
	}

	@Override
	public PasswordResetToken find(String token) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("token", token));
		PasswordResetToken passwordResetToken = (PasswordResetToken) crit.uniqueResult();
		if (passwordResetToken != null) {
			Hibernate.initialize(passwordResetToken.getUser());
		}
		return passwordResetToken;
	}

	@Override
	public PasswordResetToken findByUser(String username) {
		Criteria crit = createEntityCriteria().createCriteria("user");
		crit.add(Restrictions.eq("username", username));
		PasswordResetToken passwordResetToken = (PasswordResetToken) crit.uniqueResult();
		return passwordResetToken;
	}

	@Override
	public void deleteExpiredPasswordResetToken() {
		getSession().createSQLQuery(
				"SET SQL_SAFE_UPDATES = 0; DELETE FROM password_reset_token where date <= NOW(); SET SQL_SAFE_UPDATES = 1;");
	}

	@Override
	public PasswordResetToken findByToken(String token) {
		Criteria crit = createEntityCriteria();
		crit.add(Restrictions.eq("token", token));
		PasswordResetToken passwordResetToken = (PasswordResetToken) crit.uniqueResult();
		if (passwordResetToken != null) {
			Hibernate.initialize(passwordResetToken.getUser());
		}
		return passwordResetToken;
	}
}
