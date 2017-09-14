package com.spring.coffee.converter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import com.spring.coffee.model.Attribute;
import com.spring.coffee.service.AttributeService;

/**
 * A converter class used in views to map id's to actual userProfile objects.
 */
@Component
public class AttributeToLexicConverter implements Converter<Object, Attribute> {

	// static final Logger logger =
	// LoggerFactory.getLogger(AttributeToLexicConverter.class);

	@Autowired
	AttributeService userProfileService;

	/**
	 * Gets UserProfile by Id
	 * 
	 * @see org.springframework.core.convert.converter.Converter#convert(java.lang.Object)
	 */
	@Override
	public Attribute convert(Object element) {
		Integer id = Integer.parseInt((String) element);
		Attribute profile = userProfileService.findById(id);
		// logger.info("Profile 2: {}",profile);
		return profile;
	}
}