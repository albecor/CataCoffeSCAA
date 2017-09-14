package com.spring.coffee.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.coffee.dao.UserDao;
import com.spring.coffee.model.User;

@Service("userService")
@Transactional
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao dao;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Override
	public User selectById(int id) {
		return dao.findById(id);
	}

	@Override
	public void saveUser(User user) {
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		dao.save(user);
	}

	/*
	 * Since the method is running with Transaction, No need to call hibernate
	 * update explicitly. Just fetch the entity from db and update it with proper
	 * values within transaction. It will be updated in db once transaction ends.
	 */
	@Override
	public void updateUser(User user) {
		User entity = dao.findById(user.getId());

		if (entity != null) {

			entity.setId(user.getId());
			if (!user.getPassword().equals(entity.getPassword())) {
				entity.setPassword(passwordEncoder.encode(user.getPassword()));
			}
			entity.setFirstName(user.getFirstName());
			entity.setLastName(user.getLastName());
			entity.setEmail(user.getEmail());
			entity.setRoles(user.getRoles());
			entity.setPhone(user.getPhone());
			entity.setBirthdate(user.getBirthdate());
		}
	}

	@Override
	public void deleteUserById(int id) {
		dao.deleteById(id);
	}

	@Override
	public List<User> findAllUsers() {
		return dao.findAllUsers();
	}

	@Override
	public boolean existUser(String username) {
		User user = selectByUsername(username);
		return (user != null);
	}

	@Override
	public List<User> findUsersByRole(String type) {

		return dao.findUsersByRole(type);
	}

	@Override
	public User selectByUsername(String username) {
		return dao.findByNdivalue(username);
	}

	@Override
	public void deleteUserByUsername(String username) {
		dao.deleteByUsername(username);

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.service.UserService#existAdmin()
	 */
	@Override
	public boolean existAdmin() {
		List<User> user = dao.findUsersByRole("ADMIN");
		if (user.isEmpty())
			return false;
		return true;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.service.UserService#countAdministrators()
	 */
	@Override
	public Integer countAdministrators() {

		return dao.countAdministrators();
	}

}
