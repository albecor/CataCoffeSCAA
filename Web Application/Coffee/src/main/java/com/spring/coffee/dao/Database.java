package com.spring.coffee.dao;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.annotation.PostConstruct;

import org.apache.ibatis.jdbc.ScriptRunner;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

public class Database {

	private String driverClassName;
	private String url;
	private String username;
	private String password;
	private String scriptDatabase;
	private String database;

	public Database(String driverClassName, String url, String username, String password, String scriptDatabase,
			String database) {
		this.driverClassName = driverClassName;
		this.url = url;
		this.username = username;
		this.password = password;
		this.scriptDatabase = scriptDatabase;
		this.database = database;
	}

	/**
	 * create database in mysql server if not exist
	 */
	@PostConstruct
	public void createDataBase() {
		System.out.println("se inicio el metodo");
		try {
			DriverManagerDataSource datasource = new DriverManagerDataSource();

			datasource.setDriverClassName(driverClassName);
			datasource.setUrl(url);
			datasource.setPassword(password);
			datasource.setUsername(username);

			Connection conn;

			conn = datasource.getConnection();

			ResultSet resultSet = conn.getMetaData().getCatalogs();

			boolean exist = false;
			while (resultSet.next()) {

				if (resultSet.getString(1).equals(this.database)) {
					exist = true;
				}
			}
			resultSet.close();
			conn.close();

			if (!exist) {

				conn = datasource.getConnection();

				ScriptRunner runner = new ScriptRunner(conn);

				InputStream inputStream = getClass().getResourceAsStream(this.scriptDatabase);
				InputStreamReader reader = new InputStreamReader(inputStream);
				runner.setErrorLogWriter(null);
				runner.setLogWriter(null);

				runner.runScript(reader);

				reader.close();
				conn.close();
			}

		} catch (SQLException | IOException e) {
			e.printStackTrace();
		}

	}

	/**
	 * @return the database
	 */
	public String getDatabase() {
		return database;
	}

	/**
	 * @param database
	 *            the database to set
	 */
	public void setDatabase(String database) {
		this.database = database;
	}

	/**
	 * @return the driverClassName
	 */
	public String getDriverClassName() {
		return driverClassName;
	}

	/**
	 * @param driverClassName
	 *            the driverClassName to set
	 */
	public void setDriverClassName(String driverClassName) {
		this.driverClassName = driverClassName;
	}

	/**
	 * @return the url
	 */
	public String getUrl() {
		return url;
	}

	/**
	 * @param url
	 *            the url to set
	 */
	public void setUrl(String url) {
		this.url = url;
	}

	/**
	 * @return the username
	 */
	public String getUsername() {
		return username;
	}

	/**
	 * @param username
	 *            the username to set
	 */
	public void setUsername(String username) {
		this.username = username;
	}

	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * @param password
	 *            the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * @return the scriptDatabase
	 */
	public String getScriptDatabase() {
		return scriptDatabase;
	}

	/**
	 * @param scriptDatabase
	 *            the scriptDatabase to set
	 */
	public void setScriptDatabase(String scriptDatabase) {
		this.scriptDatabase = scriptDatabase;
	}

}
