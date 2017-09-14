package com.spring.coffee.utilities;

import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.Min;

import org.hibernate.validator.constraints.NotEmpty;

import com.spring.coffee.model.Sample;

public class Event2 {

	private Sample sample;
	@Min(1)
	private Integer cups;
	@NotEmpty
	private List<Integer> taster;
	private List<Integer> tasterTest = new ArrayList<>();

	public Event2() {
		this.sample = new Sample();
		this.taster = new ArrayList<Integer>();
		this.cups = null;
	}

	/**
	 * @return the cups
	 */
	public Integer getCups() {
		return cups;
	}

	/**
	 * @param cups
	 *            the cups to set
	 */
	public void setCups(Integer cups) {
		this.cups = cups;
	}

	/**
	 * @return the sample
	 */
	public Sample getSample() {
		return sample;
	}

	/**
	 * @param sample
	 *            the sample to set
	 */
	public void setSample(Sample sample) {
		this.sample = sample;
	}

	/**
	 * @return the taster
	 */
	public List<Integer> getTaster() {
		return taster;
	}

	/**
	 * @param taster
	 *            the taster to set
	 */
	public void setTaster(List<Integer> taster) {
		this.taster = taster;
	}

	/**
	 * @return the tasterTest
	 */
	public List<Integer> getTasterTest() {
		return tasterTest;
	}

	/**
	 * @param tasterTest
	 *            the tasterTest to set
	 */
	public void setTasterTest(List<Integer> tasterTest) {
		this.tasterTest = tasterTest;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Event [sample=" + sample + ", cups=" + cups + ", taster=" + taster + ", tasterTest=" + tasterTest + "]";
	}

}
