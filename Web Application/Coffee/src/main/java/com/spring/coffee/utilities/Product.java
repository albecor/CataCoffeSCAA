/**
 * 
 */
package com.spring.coffee.utilities;

public class Product {
	private int id;
	private String referencia;
	private String stock;
	private boolean state;

	public Product() {

	}

	public Product(int id, String referencia, String stock, boolean state) {
		super();
		this.id = id;
		this.referencia = referencia;
		this.stock = stock;
		this.state = state;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getReferencia() {
		return referencia;
	}

	public void setReferencia(String referencia) {
		this.referencia = referencia;
	}

	public String getStock() {
		return stock;
	}

	public void setStock(String stock) {
		this.stock = stock;
	}

	public boolean isState() {
		return state;
	}

	public void setState(boolean state) {
		this.state = state;
	}

}