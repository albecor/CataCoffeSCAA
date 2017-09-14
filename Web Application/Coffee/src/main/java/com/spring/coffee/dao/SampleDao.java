package com.spring.coffee.dao;

import java.util.List;

import com.spring.coffee.model.Sample;

public interface SampleDao {

	Sample findById(int id);

	Sample findByCode(String code);

	Sample findByTestId(Integer id);

	void save(Sample sample);

	void update(Sample sample);

	void deleteById(int id);

	void delete(Sample sample);

	List<Sample> findAll();

	List<Sample> selectSamplesWithoutPanel();

	List<Sample> samplesByPanel(Integer panel);

}
