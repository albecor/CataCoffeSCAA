package com.spring.coffee.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.coffee.dao.SampleDao;
import com.spring.coffee.dao.TestDao;
import com.spring.coffee.model.Sample;
import com.spring.coffee.utilities.SampleReport;

@Service("sampleService")
@Transactional
public class SampleServiceImpl implements SampleService {

	@Autowired
	SampleDao sampleDao;

	@Autowired
	TestDao testDao;

	@Override
	public Sample findById(int id) {
		return sampleDao.findById(id);
	}

	@Override
	public Sample findByCode(String code) {
		return sampleDao.findByCode(code);
	}

	@Override
	public void save(Sample sample) {
		sampleDao.save(sample);
	}

	@Override
	public void update(Sample sample) {

		Sample entity = sampleDao.findById(sample.getId());

		if (entity != null) {
			entity.setId(sample.getId());
			entity.setCode(sample.getCode());
			entity.setFr(sample.getFr());
			entity.setHeight(sample.getHeight());
			entity.setMerma(sample.getMerma());
			entity.setHumidity(sample.getHumidity());
			entity.setPasillaGrams(sample.getPasillaGrams());
			entity.setPasillaPercentage(sample.getPasillaPercentage());
			entity.setBrocaGrams(sample.getBrocaGrams());
			entity.setBrocaPercentage(sample.getBrocaPercentage());
			entity.setScore(sample.getScore());
			entity.setAlmondTotal(sample.getAlmondTotal());
			entity.setAlmondHealthy(sample.getAlmondHealthy());
			entity.setNotesPhysicalAnalysis(sample.getNotesPhysicalAnalysis());
			entity.setGrower(sample.getGrower());
			entity.setGrowerId(sample.getGrowerId());
			entity.setDepartament(sample.getDepartament());
			entity.setMunicipalityGrower(sample.getMunicipalityGrower());
			entity.setVeredaGrower(sample.getVeredaGrower());
			entity.setVariety(sample.getVariety());
			entity.setDate(sample.getDate());
			entity.setPhone(sample.getPhone());
			entity.setLocation(sample.getLocation());

			entity.setTest(sample.getTest());

		}
	}

	@Override
	public void deleteById(Integer id) {
		Sample sample = sampleDao.findById(id);
		sampleDao.deleteById(id);
	}

	@Override
	public List<Sample> findAll() {
		return sampleDao.findAll();
	}

	@Override
	public List<Sample> selectSamplesWithoutPanel() {

		return sampleDao.selectSamplesWithoutPanel();
	}

	@Override
	public void deleteSampleWithoutPanel(Integer id) {

		List<Sample> samples = selectSamplesWithoutPanel();
		for (Sample sample : samples) {
			if (sample.getId() == id) {

				sampleDao.deleteById(id);

			}
		}

	}

	@Override
	public List<Sample> samplesByPanel(Integer panel) {
		return sampleDao.samplesByPanel(panel);
	}

	@Override
	public void delete(Sample sample) {
		sampleDao.delete(sample);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.service.SampleService#de()
	 */
	@Override
	public List<Sample> de() {
		return Arrays.asList(new Sample("codigo", "altura"), new Sample("codigo2", "altura2"),
				new Sample("codigo3", "altura3"), new Sample("codigo4", "altura4"), new Sample("codigo2", "altura2"),
				new Sample("codigo2", "altura2"));
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.spring.coffee.service.SampleService#findByTestId(java.lang.Integer)
	 */
	@Override
	public Sample findByTestId(Integer id) {

		return sampleDao.findByTestId(id);
	}

	@Override
	public List<SampleReport> sampleReport(Sample sample) {
		List<SampleReport> reporte = new ArrayList<>();
		reporte.add(new SampleReport(sample));
		return reporte;
	}

}
