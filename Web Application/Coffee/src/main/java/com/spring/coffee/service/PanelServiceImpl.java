package com.spring.coffee.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.coffee.dao.PanelDao;
import com.spring.coffee.model.Panel;

@Service("panelService")
@Transactional
public class PanelServiceImpl implements PanelService {

	@Autowired
	PanelDao panelDao;

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.service.PanelService#findAll()
	 */
	@Override
	public List<Panel> findAll() {
		// TODO Auto-generated method stub
		return panelDao.findAll();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.service.PanelService#findById(java.lang.Integer)
	 */
	@Override
	public Panel findById(Integer id) {

		return panelDao.findById(id);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.service.PanelService#delete(java.lang.Integer)
	 */
	@Override
	public void delete(Integer id) {
		panelDao.delete(id);

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.service.PanelService#save(com.spring.coffee.model.
	 * Panel)
	 */
	@Override
	public void save(Panel panel) {
		panelDao.save(panel);

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.service.PanelService#unauthorized()
	 */
	@Override
	public List<Panel> unauthorized() {
		return panelDao.unauthorized();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.spring.coffee.service.PanelService#update(com.spring.coffee.model.Panel)
	 */
	@Override
	public void update(Panel panel) {
		panelDao.update(panel);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.spring.coffee.service.PanelService#authorizedByUserId(java.lang.Integer)
	 */
	@Override
	public List<Panel> authorizedByUserId(Integer userId) {
		return panelDao.authorizedByUserId(userId);
	}

}