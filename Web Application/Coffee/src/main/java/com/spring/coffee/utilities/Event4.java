package com.spring.coffee.utilities;

import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.Min;

public class Event4 {

	@Min(1)
	private Integer cups;
	private List<Integer> tasterId;
	private List<Integer> sampleId;

	public Event4() {
		this.cups = null;
		this.tasterId = new ArrayList<Integer>();
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
	 * @return the tasterId
	 */
	public List<Integer> getTasterId() {
		return tasterId;
	}

	/**
	 * @param tasterId
	 *            the tasterId to set
	 */
	public void setTasterId(List<Integer> tasterId) {
		this.tasterId = tasterId;
	}

	/**
	 * @return the sampleId
	 */
	public List<Integer> getSampleId() {
		return sampleId;
	}

	/**
	 * @param sampleId
	 *            the sampleId to set
	 */
	public void setSampleId(List<Integer> sampleId) {
		this.sampleId = sampleId;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Event4 [cups=" + cups + ", tasterId=" + tasterId + ", sampleId=" + sampleId + "]";
	}

}
