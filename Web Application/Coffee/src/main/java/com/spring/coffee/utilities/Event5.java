package com.spring.coffee.utilities;

import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.Min;

import com.spring.coffee.model.Sample;
import com.spring.coffee.model.Test;
import com.spring.coffee.model.User;

public class Event5 {

	@Min(1)
	private Integer cups;
	private List<User> taster;
	private List<Sample> sample = new ArrayList<>();
	private List<Test> tasterTest = new ArrayList<>();

	public Event5() {
		this.sample = new ArrayList<Sample>();
		this.taster = new ArrayList<User>();
		this.tasterTest = new ArrayList<Test>();
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
	 * @return the taster
	 */
	public List<User> getTaster() {
		return taster;
	}

	/**
	 * @param taster
	 *            the taster to set
	 */
	public void setTaster(List<User> taster) {
		this.taster = taster;
	}

	/**
	 * @return the sample
	 */
	public List<Sample> getSample() {
		return sample;
	}

	/**
	 * @param sample
	 *            the sample to set
	 */
	public void setSample(List<Sample> sample) {
		this.sample = sample;
	}

	/**
	 * @return the tasterTest
	 */
	public List<Test> getTasterTest() {
		return tasterTest;
	}

	/**
	 * @param tasterTest
	 *            the tasterTest to set
	 */
	public void setTasterTest(List<Test> tasterTest) {
		this.tasterTest = tasterTest;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Event5 [cups=" + cups + ", taster=" + taster + ", sample=" + sample + ", tasterTest=" + tasterTest
				+ "]";
	}

}
