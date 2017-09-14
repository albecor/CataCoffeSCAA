/**
 * 
 */
package com.spring.coffee.utilities;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import com.spring.coffee.model.Sample;
import com.spring.coffee.model.Test;

/**
 * @author CHAPAL
 *
 */
public class sampleco {

	public static Collection<SampleReport> load() {

		List<SampleReport> samplesReport = new ArrayList<>();

		Sample sample = new Sample();
		sample.setAlmondHealthy("almondHealthy");
		sample.setAlmondTotal("almondTotal");
		sample.setBrocaGrams("brocaGrams");
		sample.setBrocaPercentage("brocaPercentage");
		sample.setCode("code");
		sample.setDate(new Date());
		sample.setDepartament("" + new Date());
		sample.setFr("fr");
		sample.setGrower("grower");
		sample.setGrowerId("107524614");
		sample.setHeight("2500");
		sample.setHumidity("854");
		sample.setId(1);
		sample.setLocation("location");
		sample.setMerma("1.1");
		sample.setMunicipalityGrower("municipalityGrower");
		sample.setNotesPhysicalAnalysis(
				"notesPhysicalAnalysis ESTA MUY BOINOT PERP NO ES MI TIPI DE ANALISI DEBERIAN DE JAR LAC OCOSAS COMO ESTAN Y ASI perfecionar el atentando");
		sample.setPasillaGrams("pasillaGrams");
		sample.setPasillaPercentage("pasillaPercentage");
		sample.setPhone("phone");
		sample.setVariety("variety");
		sample.setVeredaGrower("veredaGrower");

		Test test = new Test();
		test.setFragranceNotes("fragranceNotes estas son mis mnota para la fragancia");
		test.setFlavorNotes("flavorNotes estas son mis notas para el sabor");
		test.setAcidityNotes("acidityNotes estas son mis notas para la acides");
		test.setBodyNotes("bodyNotes el cuerpo no tas es masn candente");
		test.setTotalScore("totalScore");
		test.setNotes("notes");
		test.setFragrance("7.5");
		test.setAroma("8.5");
		test.setFlavor("8.25");
		test.setResidualFlavor("9");
		test.setAcidity("8.75");
		test.setBody("6.75");
		test.setUniformity("7.75");
		test.setBalance("9.5");
		test.setCleanCup("8.25");
		test.setSweetness("9.75");
		test.setTasterScore("8.25");

		/*
		 * 
		 * private String fragranceNotes; private String flavorNotes; private String
		 * acidityNotes; private String bodyNotes; private String score; private String
		 * notes;
		 */

		sample.setTest(test);
		samplesReport.add(new SampleReport(sample));
		return samplesReport;

	}

}
