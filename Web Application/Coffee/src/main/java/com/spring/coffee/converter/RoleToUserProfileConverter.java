package com.spring.coffee.converter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import com.spring.coffee.model.Role;
import com.spring.coffee.service.RoleService;

/**
 * A converter class used in views to map id's to actual userProfile objects.
 */
@Component
public class RoleToUserProfileConverter implements Converter<Object, Role> {

	// static final Logger logger =
	// LoggerFactory.getLogger(RoleToUserProfileConverter.class);

	@Autowired
	RoleService userProfileService;

	/**
	 * Gets UserProfile by Id
	 * 
	 * @see org.springframework.core.convert.converter.Converter#convert(java.lang.Object)
	 */
	@Override
	public Role convert(Object element) {
		Integer id = Integer.parseInt((String) element);
		Role profile = userProfileService.findById(id);
		// logger.info("Profile : {}",profile);
		return profile;
	}
}