package com.spring.coffee.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import com.spring.coffee.dao.Database;

@Controller
public class AppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

	@Autowired
	Database database;

	@Override
	protected Class<?>[] getRootConfigClasses() {
		return new Class[] { AppConfig.class };
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		return null;
	}

	@Override
	protected String[] getServletMappings() {
		// database.createDataBase();
		return new String[] { "/" };
	}

}
