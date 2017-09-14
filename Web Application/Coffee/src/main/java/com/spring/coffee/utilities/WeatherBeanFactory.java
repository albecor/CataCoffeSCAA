/**
 * 
 */
package com.spring.coffee.utilities;

import java.util.Collection;
import java.util.Vector;

public class WeatherBeanFactory {

	public static Collection<WeatherBean> getWeatherBeans() {
		Vector<WeatherBean> allbeans = new Vector<WeatherBean>();
		try {
			allbeans.add(new WeatherBean("Delhi", "Sunny", 41));
			allbeans.add(new WeatherBean("Mumbai", "Cloudy", 36));
			allbeans.add(new WeatherBean("Bangalore", "Rainy", 28));
			allbeans.add(new WeatherBean("Hyderabad", "Sunny", 39));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return allbeans;
	}
}