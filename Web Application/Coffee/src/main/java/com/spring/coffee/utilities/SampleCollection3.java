/**
 * 
 */
package com.spring.coffee.utilities;

import java.util.ArrayList;
import java.util.List;

import com.spring.coffee.model.Sample;

public class SampleCollection3 {

	public static List<Sample> load() {
		List<Sample> list = new ArrayList<Sample>();
		list.add(new Sample("codigo 2", "altura 2"));
		list.add(new Sample("codigo 4", "altura 4"));
		list.add(new Sample("codigo 3", "altura 3"));
		return list;
	}
}
