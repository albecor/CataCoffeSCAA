package com.spring.coffee.service;

import java.util.List;

import com.spring.coffee.model.Sample;
import com.spring.coffee.utilities.SampleReport;

public interface SampleService {

	Sample findById(int id);

	Sample findByCode(String code);

	void save(Sample sample);

	void update(Sample sample);

	void delete(Sample sample);

	void deleteById(Integer id);

	void deleteSampleWithoutPanel(Integer id);

	List<Sample> findAll();

	List<Sample> de();

	List<SampleReport> sampleReport(Sample sample);

	List<Sample> selectSamplesWithoutPanel();

	List<Sample> samplesByPanel(Integer panel);

	Sample findByTestId(Integer id);

}
