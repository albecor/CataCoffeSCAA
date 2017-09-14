package com.spring.coffee.utilities;

public class PersonBean {
	private String name = "";
	private int age = 0;

	public PersonBean(String name, int age) {
		this.name = name;
		this.age = age;
	}

	public int getAge() {
		return age;
	}

	public String getName() {
		return name;
	}
}