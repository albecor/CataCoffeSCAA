package com.spring.coffee.service;

import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.coffee.dao.PasswordResetTokenDao;
import com.spring.coffee.dao.UserDao;
import com.spring.coffee.model.PasswordResetToken;
import com.spring.coffee.model.User;

@Service("passwordResetTokenService")
@Transactional
public class PasswordResetTokenServiceImpl implements PasswordResetTokenService {

	@Autowired
	PasswordResetTokenDao dao;

	@Autowired
	UserDao userDao;

	@Override
	public void insert(PasswordResetToken passwordResetToken) {
		dao.insert(passwordResetToken);
	}

	@Override
	public PasswordResetToken find(String token) {

		return dao.find(token);
	}

	@Override
	public void delete(int id) {
		dao.delete(id);
	}

	@Override
	public void deleteByUser(String username) {
		PasswordResetToken passwordResetToken = dao.findByUser(username);
		if (passwordResetToken != null)
			dao.delete(passwordResetToken.getId());
	}

	@Override
	public void deleteExpiredPasswordResetToken() {
		dao.deleteExpiredPasswordResetToken();
	}

	@Override
	public String validatePasswordResetToken(Integer id, String token) {
		PasswordResetToken passToken = dao.findByToken(token);
		
		if(passToken == null) {
			return "invalidToken";
		}
		if ((passToken.getId() == null) || (passToken.getUser().getId() != id)) {
			return "invalidToken";
		}

		Date dt = passToken.getDate();
		Calendar c = Calendar.getInstance();
		c.setTime(dt);
		c.add(Calendar.DATE, 1);
		dt = c.getTime();

		if ((dt.getTime() - new Date().getTime()) <= 0) {
			return "expired";
		}

		User user = passToken.getUser();
		Authentication auth = new UsernamePasswordAuthenticationToken(user, null,
				Arrays.asList(new SimpleGrantedAuthority("CHANGE_PASSWORD_PRIVILEGE")));
		SecurityContextHolder.getContext().setAuthentication(auth);

		return null;
	}
}