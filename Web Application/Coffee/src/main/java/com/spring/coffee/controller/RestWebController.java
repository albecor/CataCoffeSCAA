package com.spring.coffee.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.spring.coffee.model.Attribute;
import com.spring.coffee.model.Test;
import com.spring.coffee.service.AttributeService;
import com.spring.coffee.service.TestService;
import com.spring.coffee.utilities.Customer;
import com.spring.coffee.utilities.Response;

@RestController
public class RestWebController {
	@Autowired
	AttributeService attributeService;

	@Autowired
	TestService testService;

	List<Customer> cust = new ArrayList<Customer>();

	@RequestMapping(value = "/getallcustomerk", method = RequestMethod.GET)
	public Response getResource() {
		Response response = new Response("Done", cust);
		return response;
	}

	@RequestMapping(value = "/postcustomer2", method = RequestMethod.POST)
	public Response postCustomer(@RequestBody Test test) {
		Set<Attribute> attributes = new HashSet<>();
		for (Attribute attribute : test.getAttributes()) {
			attributes.add(attributeService.findById(attribute.getId()));
		}
		test.setAttributes(attributes);

		testService.update(test);
		

		Response response = new Response("Done", test);

		return response;
	}
}