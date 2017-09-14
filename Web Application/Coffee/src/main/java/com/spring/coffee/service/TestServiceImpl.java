package com.spring.coffee.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.coffee.dao.TestDao;
import com.spring.coffee.model.Test;

@Transactional
@Service("testService")
public class TestServiceImpl implements TestService {

	@Autowired
	TestDao dao;

	@Override
	public Test findById(int id) {

		return dao.findById(id);
	}

	@Override
	public void save(Test test) {
		dao.save(test);
	}

	@Override
	public void deleteById(int id) {
		dao.deleteById(id);
	}

	@Override
	public List<Test> findStartedByUser(Integer id) {
		return dao.findStartedByUser(id);
	}

	@Override
	public List<Test> findEndedByUser() {
		return dao.findEndedByUser();
	}

	@Override
	public void update(Test test) {
		Test entity = dao.findById(test.getId());

		if (entity != null) {
			entity.setId(test.getId());
			entity.setFragrance(test.getFragrance());
			entity.setFragranceNotes(test.getFragranceNotes());
			entity.setAroma(test.getAroma());
			entity.setAromaNotes(test.getAromaNotes());
			entity.setFlavor(test.getFlavor());
			entity.setFlavorNotes(test.getFlavorNotes());
			entity.setResidualFlavor(test.getResidualFlavor());
			entity.setResidualFlavorNotes(test.getResidualFlavorNotes());
			entity.setAcidity(test.getAcidity());
			entity.setAcidityNotes(test.getAcidityNotes());
			entity.setBody(test.getBody());
			entity.setBodyNotes(test.getBodyNotes());
			entity.setUniformity(test.getUniformity());
			entity.setUniformityNotes(test.getUniformityNotes());
			entity.setUniformityOrder(test.getUniformityOrder());
			entity.setBalance(test.getBalance());
			entity.setBalanceNotes(test.getBalanceNotes());
			entity.setCleanCup(test.getCleanCup());
			entity.setCleanCupNotes(test.getCleanCupNotes());
			entity.setCleanCupOrder(test.getCleanCupOrder());
			entity.setSweetness(test.getSweetness());
			entity.setSweetnessNotes(test.getSweetnessNotes());
			entity.setSweetnessOrder(test.getSweetnessOrder());
			entity.setTasterScore(test.getTasterScore());
			entity.setDefect(test.getDefect());
			entity.setDefectNotes(test.getDefectNotes());
			entity.setDefectOrder(test.getDefectOrder());
			entity.setCups(test.getCups());
			entity.setTotalScore(test.getTotalScore());
			entity.setNotes(test.getNotes());
			entity.setAttributes(test.getAttributes());
			entity.setFinished(test.getFinished());
			entity.setDisableScore(test.getDisableScore());

		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.service.TestService#findAll()
	 */
	@Override
	public List<Test> findAll() {

		return dao.findAll();
	}
}
