package com.spring.coffee.model;
// Generated 12/09/2017 01:17:12 PM by Hibernate Tools 5.2.5.Final

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * TestsId generated by hbm2java
 */
@Embeddable
public class TestsId implements java.io.Serializable {

	private int testId;
	private int sampleId;
	private int userId;
	private int panelId;

	public TestsId() {
	}

	public TestsId(int testId, int sampleId, int userId, int panelId) {
		this.testId = testId;
		this.sampleId = sampleId;
		this.userId = userId;
		this.panelId = panelId;
	}

	@Column(name = "test_id", nullable = false)
	public int getTestId() {
		return this.testId;
	}

	public void setTestId(int testId) {
		this.testId = testId;
	}

	@Column(name = "sample_id", nullable = false)
	public int getSampleId() {
		return this.sampleId;
	}

	public void setSampleId(int sampleId) {
		this.sampleId = sampleId;
	}

	@Column(name = "user_id", nullable = false)
	public int getUserId() {
		return this.userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	@Column(name = "panel_id", nullable = false)
	public int getPanelId() {
		return this.panelId;
	}

	public void setPanelId(int panelId) {
		this.panelId = panelId;
	}

	@Override
	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof TestsId))
			return false;
		TestsId castOther = (TestsId) other;

		return (this.getTestId() == castOther.getTestId()) && (this.getSampleId() == castOther.getSampleId())
				&& (this.getUserId() == castOther.getUserId()) && (this.getPanelId() == castOther.getPanelId());
	}

	@Override
	public int hashCode() {
		int result = 17;

		result = 37 * result + this.getTestId();
		result = 37 * result + this.getSampleId();
		result = 37 * result + this.getUserId();
		result = 37 * result + this.getPanelId();
		return result;
	}

	@Override
	public String toString() {
		return "TestsId [testId=" + testId + ", sampleId=" + sampleId + ", userId=" + userId + ", panelId=" + panelId
				+ "]";
	}

	
	
}
