/**
 * 
 */
package com.spring.coffee.utilities;

public class WeatherBean {
	private String cityName = "";
	private String weatherType = "";
	private int temperature = 0;

	public WeatherBean(String cityName, String weatherType, int temperature) {
		this.cityName = cityName;
		this.weatherType = weatherType;
		this.temperature = temperature;
	}

	public String getcityName() {
		return cityName;
	}

	public String getweatherType() {
		return weatherType;
	}

	public int gettemperature() {
		return temperature;
	}
}