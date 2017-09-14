/**
 * 
 */
package com.spring.coffee.utilities;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Vector;

import javax.imageio.ImageIO;

import com.spring.coffee.model.Sample;

/**
 * @author CHAPAL
 *
 */
public class SampleReport {

	private Date date;
	private String code;
	private String grower;
	private String growerId;
	private String departament;
	private String municipalityGrower;
	private String veredaGrower;
	private String variety;
	private String height;
	private String phone;
	private String humidity;
	private String almondTotal;
	private String almondHealthy;
	private String pasillaGrams;
	private String pasillaPercentage;
	private String brocaGrams;
	private String brocaPercentage;
	private String merma;
	private String fr;
	private String notesPhysicalAnalysis;
	private List<SpiderChart> spidercharts;
	private String fragranceNotes;
	private String flavorNotes;
	private String acidityNotes;
	private String bodyNotes;
	private String score;
	private String notes;
	private BufferedImage cabecera;
	private BufferedImage firma1;
	private BufferedImage firma2;
	private BufferedImage bean;
	private Collection<Number> ko;

	public SampleReport(Sample sample) {
		this.setDate(sample.getDate());
		this.setCode(sample.getCode());
		this.setGrower(sample.getGrower());
		this.setGrowerId("" + sample.getGrowerId());
		this.setDepartament(sample.getDepartament());
		this.setMunicipalityGrower(sample.getMunicipalityGrower());
		this.setVeredaGrower(sample.getVeredaGrower());
		this.setVariety(sample.getVariety());
		this.setHeight(sample.getHeight());
		this.setPhone(sample.getPhone());
		this.setHumidity(sample.getHumidity());
		this.setAlmondTotal(sample.getAlmondTotal());
		this.setAlmondHealthy(sample.getAlmondHealthy());
		this.setPasillaGrams(sample.getPasillaGrams());
		this.setPasillaPercentage(sample.getPasillaPercentage());
		this.setBrocaGrams(sample.getBrocaGrams());
		this.setBrocaPercentage(sample.getBrocaPercentage());
		this.setMerma(sample.getMerma());
		this.setFr(sample.getFr());
		this.setNotesPhysicalAnalysis(sample.getNotesPhysicalAnalysis());
		this.setFragranceNotes(sample.getTest().getFragranceNotes());
		this.setFlavorNotes(sample.getTest().getFlavorNotes());
		this.setAcidityNotes(sample.getTest().getAcidityNotes());
		this.setScore(sample.getTest().getTotalScore());
		this.setNotes(sample.getTest().getNotes());
		this.setBodyNotes(sample.getTest().getBodyNotes());

		try {
			this.cabecera = ImageIO.read(getClass().getResource("/jasperreports/images/cabecera.jpg"));
			this.firma1 = ImageIO.read(getClass().getResource("/jasperreports/images/f1.png"));
			this.firma2 = ImageIO.read(getClass().getResource("/jasperreports/images/f2.png"));
			this.bean = ImageIO.read(getClass().getResource("/jasperreports/images/cafe.png"));
			System.out.println("cargada la cabecera :)");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		this.spidercharts = new ArrayList<>();
		Double fa = (Double.parseDouble(sample.getTest().getFragrance())
				+ Double.parseDouble(sample.getTest().getAroma())) / 2;

		this.spidercharts.add(new SpiderChart("Sabor", "Sensorial", Double.parseDouble(sample.getTest().getFlavor())));
		this.spidercharts.add(new SpiderChart("Sabor residual", "Sensorial",
				Double.parseDouble(sample.getTest().getResidualFlavor())));
		this.spidercharts
				.add(new SpiderChart("Acidez", "Sensorial", Double.parseDouble(sample.getTest().getAcidity())));
		this.spidercharts.add(new SpiderChart("Cuerpo", "Sensorial", Double.parseDouble(sample.getTest().getBody())));
		this.spidercharts
				.add(new SpiderChart("Uniformidad", "Sensorial", Double.parseDouble(sample.getTest().getUniformity())));
		this.spidercharts
				.add(new SpiderChart("Balance", "Sensorial", Double.parseDouble(sample.getTest().getBalance())));
		this.spidercharts
				.add(new SpiderChart("Taza limpia", "Sensorial", Double.parseDouble(sample.getTest().getCleanCup())));
		this.spidercharts
				.add(new SpiderChart("Dulzor", "Sensorial", Double.parseDouble(sample.getTest().getSweetness())));
		this.spidercharts
				.add(new SpiderChart("Catador", "Sensorial", Double.parseDouble(sample.getTest().getTasterScore())));
		this.spidercharts.add(new SpiderChart("Fragancia/Aroma", "Sensorial", fa));

		this.ko = new Vector<Number>();
		ko.add(new Integer(22));
		ko.add(new Integer(5));
		ko.add(new Integer(8));
	}

	/**
	 * @return the date
	 */
	public Date getDate() {
		return date;
	}

	/**
	 * @param date
	 *            the date to set
	 */
	public void setDate(Date date) {
		this.date = date;
	}

	/**
	 * @return the code
	 */
	public String getCode() {
		return code;
	}

	/**
	 * @param code
	 *            the code to set
	 */
	public void setCode(String code) {
		this.code = code;
	}

	/**
	 * @return the grower
	 */
	public String getGrower() {
		return grower;
	}

	/**
	 * @param grower
	 *            the grower to set
	 */
	public void setGrower(String grower) {
		this.grower = grower;
	}

	/**
	 * @return the growerId
	 */
	public String getGrowerId() {
		return growerId;
	}

	/**
	 * @param growerId
	 *            the growerId to set
	 */
	public void setGrowerId(String growerId) {
		this.growerId = growerId;
	}

	/**
	 * @return the departament
	 */
	public String getDepartament() {
		return departament;
	}

	/**
	 * @param departament
	 *            the departament to set
	 */
	public void setDepartament(String departament) {
		this.departament = departament;
	}

	/**
	 * @return the municipalityGrower
	 */
	public String getMunicipalityGrower() {
		return municipalityGrower;
	}

	/**
	 * @param municipalityGrower
	 *            the municipalityGrower to set
	 */
	public void setMunicipalityGrower(String municipalityGrower) {
		this.municipalityGrower = municipalityGrower;
	}

	/**
	 * @return the veredaGrower
	 */
	public String getVeredaGrower() {
		return veredaGrower;
	}

	/**
	 * @param veredaGrower
	 *            the veredaGrower to set
	 */
	public void setVeredaGrower(String veredaGrower) {
		this.veredaGrower = veredaGrower;
	}

	/**
	 * @return the variety
	 */
	public String getVariety() {
		return variety;
	}

	/**
	 * @param variety
	 *            the variety to set
	 */
	public void setVariety(String variety) {
		this.variety = variety;
	}

	/**
	 * @return the height
	 */
	public String getHeight() {
		return height;
	}

	/**
	 * @param height
	 *            the height to set
	 */
	public void setHeight(String height) {
		this.height = height;
	}

	/**
	 * @return the phone
	 */
	public String getPhone() {
		return phone;
	}

	/**
	 * @param phone
	 *            the phone to set
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/**
	 * @return the humidity
	 */
	public String getHumidity() {
		return humidity;
	}

	/**
	 * @param humidity
	 *            the humidity to set
	 */
	public void setHumidity(String humidity) {
		this.humidity = humidity;
	}

	/**
	 * @return the almondTotal
	 */
	public String getAlmondTotal() {
		return almondTotal;
	}

	/**
	 * @param almondTotal
	 *            the almondTotal to set
	 */
	public void setAlmondTotal(String almondTotal) {
		this.almondTotal = almondTotal;
	}

	/**
	 * @return the almondHealthy
	 */
	public String getAlmondHealthy() {
		return almondHealthy;
	}

	/**
	 * @param almondHealthy
	 *            the almondHealthy to set
	 */
	public void setAlmondHealthy(String almondHealthy) {
		this.almondHealthy = almondHealthy;
	}

	/**
	 * @return the pasillaGrams
	 */
	public String getPasillaGrams() {
		return pasillaGrams;
	}

	/**
	 * @param pasillaGrams
	 *            the pasillaGrams to set
	 */
	public void setPasillaGrams(String pasillaGrams) {
		this.pasillaGrams = pasillaGrams;
	}

	/**
	 * @return the pasillaPercentage
	 */
	public String getPasillaPercentage() {
		return pasillaPercentage;
	}

	/**
	 * @param pasillaPercentage
	 *            the pasillaPercentage to set
	 */
	public void setPasillaPercentage(String pasillaPercentage) {
		this.pasillaPercentage = pasillaPercentage;
	}

	/**
	 * @return the brocaGrams
	 */
	public String getBrocaGrams() {
		return brocaGrams;
	}

	/**
	 * @param brocaGrams
	 *            the brocaGrams to set
	 */
	public void setBrocaGrams(String brocaGrams) {
		this.brocaGrams = brocaGrams;
	}

	/**
	 * @return the brocaPercentage
	 */
	public String getBrocaPercentage() {
		return brocaPercentage;
	}

	/**
	 * @param brocaPercentage
	 *            the brocaPercentage to set
	 */
	public void setBrocaPercentage(String brocaPercentage) {
		this.brocaPercentage = brocaPercentage;
	}

	/**
	 * @return the merma
	 */
	public String getMerma() {
		return merma;
	}

	/**
	 * @param merma
	 *            the merma to set
	 */
	public void setMerma(String merma) {
		this.merma = merma;
	}

	/**
	 * @return the fr
	 */
	public String getFr() {
		return fr;
	}

	/**
	 * @param fr
	 *            the fr to set
	 */
	public void setFr(String fr) {
		this.fr = fr;
	}

	/**
	 * @return the notesPhysicalAnalysis
	 */
	public String getNotesPhysicalAnalysis() {
		return notesPhysicalAnalysis;
	}

	/**
	 * @param notesPhysicalAnalysis
	 *            the notesPhysicalAnalysis to set
	 */
	public void setNotesPhysicalAnalysis(String notesPhysicalAnalysis) {
		this.notesPhysicalAnalysis = notesPhysicalAnalysis;
	}

	/**
	 * @return the fragranceNotes
	 */
	public String getFragranceNotes() {
		return fragranceNotes;
	}

	/**
	 * @param fragranceNotes
	 *            the fragranceNotes to set
	 */
	public void setFragranceNotes(String fragranceNotes) {
		this.fragranceNotes = fragranceNotes;
	}

	/**
	 * @return the flavorNotes
	 */
	public String getFlavorNotes() {
		return flavorNotes;
	}

	/**
	 * @param flavorNotes
	 *            the flavorNotes to set
	 */
	public void setFlavorNotes(String flavorNotes) {
		this.flavorNotes = flavorNotes;
	}

	/**
	 * @return the acidityNotes
	 */
	public String getAcidityNotes() {
		return acidityNotes;
	}

	/**
	 * @param acidityNotes
	 *            the acidityNotes to set
	 */
	public void setAcidityNotes(String acidityNotes) {
		this.acidityNotes = acidityNotes;
	}

	/**
	 * @return the bodyNotes
	 */
	public String getBodyNotes() {
		return bodyNotes;
	}

	/**
	 * @param bodyNotes
	 *            the bodyNotes to set
	 */
	public void setBodyNotes(String bodyNotes) {
		this.bodyNotes = bodyNotes;
	}

	/**
	 * @return the score
	 */
	public String getScore() {
		return score;
	}

	/**
	 * @param score
	 *            the score to set
	 */
	public void setScore(String score) {
		this.score = score;
	}

	/**
	 * @return the notes
	 */
	public String getNotes() {
		return notes;
	}

	/**
	 * @param notes
	 *            the notes to set
	 */
	public void setNotes(String notes) {
		this.notes = notes;
	}

	/**
	 * @return the spidercharts
	 */
	public List<SpiderChart> getSpidercharts() {
		return spidercharts;
	}

	/**
	 * @param spidercharts
	 *            the spidercharts to set
	 */
	public void setSpidercharts(List<SpiderChart> spidercharts) {
		this.spidercharts = spidercharts;
	}

	/**
	 * @return the ko
	 */
	public Collection<Number> getKo() {
		return ko;
	}

	/**
	 * @param ko
	 *            the ko to set
	 */
	public void setKo(Collection<Number> ko) {
		this.ko = ko;
	}

	public BufferedImage getCabecera() {
		return cabecera;
	}

	public void setCabecera(BufferedImage cabecera) {
		this.cabecera = cabecera;
	}

	public BufferedImage getFirma1() {
		return firma1;
	}

	public void setFirma1(BufferedImage firma1) {
		this.firma1 = firma1;
	}

	public BufferedImage getFirma2() {
		return firma2;
	}

	public void setFirma2(BufferedImage firma2) {
		this.firma2 = firma2;
	}

	public BufferedImage getBean() {
		return bean;
	}

	public void setBean(BufferedImage bean) {
		this.bean = bean;
	}

}
