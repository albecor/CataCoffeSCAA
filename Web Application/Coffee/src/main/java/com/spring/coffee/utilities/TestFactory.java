package com.spring.coffee.utilities;

import java.util.ArrayList;
import java.util.List;

public class TestFactory {

	public static List<PersonBean> generateCollection() {

		List<PersonBean> list = new ArrayList<PersonBean>();

		list.add(new PersonBean("cata", 5));
		list.add(new PersonBean("cata5", 1));

		list.add(new PersonBean("cata4", 3));

		return list;

	}

}