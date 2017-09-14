package com.spring.coffee.service;

public class Customer {
	private Integer ID;
	private String FIRSTNAME;
	private String LASTNAME;
	private String STREET;
	private String CITY;

	/**
	 * @param iD
	 * @param fIRSTNAME
	 * @param lASTNAME
	 * @param sTREET
	 * @param cITY
	 */
	public Customer(Integer iD, String fIRSTNAME, String lASTNAME, String sTREET, String cITY) {

		ID = iD;
		FIRSTNAME = fIRSTNAME;
		LASTNAME = lASTNAME;
		STREET = sTREET;
		CITY = cITY;
	}

	/**
	 * @return the iD
	 */
	public Integer getID() {
		return ID;
	}

	/**
	 * @param iD
	 *            the iD to set
	 */
	public void setID(Integer iD) {
		ID = iD;
	}

	/**
	 * @return the fIRSTNAME
	 */
	public String getFIRSTNAME() {
		return FIRSTNAME;
	}

	/**
	 * @param fIRSTNAME
	 *            the fIRSTNAME to set
	 */
	public void setFIRSTNAME(String fIRSTNAME) {
		FIRSTNAME = fIRSTNAME;
	}

	/**
	 * @return the lASTNAME
	 */
	public String getLASTNAME() {
		return LASTNAME;
	}

	/**
	 * @param lASTNAME
	 *            the lASTNAME to set
	 */
	public void setLASTNAME(String lASTNAME) {
		LASTNAME = lASTNAME;
	}

	/**
	 * @return the sTREET
	 */
	public String getSTREET() {
		return STREET;
	}

	/**
	 * @param sTREET
	 *            the sTREET to set
	 */
	public void setSTREET(String sTREET) {
		STREET = sTREET;
	}

	/**
	 * @return the cITY
	 */
	public String getCITY() {
		return CITY;
	}

	/**
	 * @param cITY
	 *            the cITY to set
	 */
	public void setCITY(String cITY) {
		CITY = cITY;
	}

}
